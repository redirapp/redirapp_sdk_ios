import Foundation
import UIKit
import Alamofire

@objc public class Redirapp: NSObject {
    
    // MARK: - Static properties
    
    private static let baseUrl: String = "https://api.redirapp.com"
    private static let userDefaultsKey: String = "redirapp"
    private static let customerTokenUserDefaultsKey: String = "customerToken"
    private static var appId: String? = nil
    private static let defaults: UserDefaults = UserDefaults.init(suiteName: userDefaultsKey)!
    
    // MARK: - Initialize Method
    
    public class func initialize(_ appId: String) {
        Redirapp.appId = appId
        
        guard getCustomerToken() == nil else {
            return
        }
        
        logInstallation()
    }
    
    // MARK: - Customer Methods
    
    private class func getCustomerToken() -> String? {
        return Redirapp.defaults.string(forKey: Redirapp.customerTokenUserDefaultsKey)
    }
    
    private class func setCustomerToken(_ customerToken: String) {
        Redirapp.defaults.setValue(customerToken, forKey: Redirapp.customerTokenUserDefaultsKey)
    }
    
    // MARK: - Log Methods
    
    private class func logInstallation() {
        guard getCustomerToken() == nil else {
            return // Already initialized... don't log it...
        }
        
        guard let redirAppId = Redirapp.appId else {
            return // No app id initialized...
        }
        
        Redirapp.request("/apps/\(redirAppId)/log_install") { (result) in
            Redirapp.setCustomerToken(result["customer_token"] as! String)
        }
    }
    
    public class func logPurchase(amount: Double, sku: String) {
        logPurchase(amount: amount, currency: "USD", sku: sku)
    }
    
    public class func logPurchase(amount: Double, currency: String, sku: String) {
        guard let customerToken = getCustomerToken() else {
            return //Not initialized... don't log it...
        }
        
        guard let redirAppId = Redirapp.appId else {
            return // No app id initialized...
        }
        
        Redirapp.request(
            "/apps/\(redirAppId)/log_purchase",
            parameters: [
                "customer_token": customerToken,
                "amount": amount,
                "currency": currency,
                "sku": sku
            ]
        )
    }
    
    // MARK: - Request Methods
    
    private class func request(
        _ path: String,
        parameters: [String : Any] = [:],
        completion: ((_ result: [String : Any]) -> Void)? = nil
    ) {
        let url = "\(Redirapp.baseUrl)/\(path)"
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")! + " Redirapp"
        let headers:HTTPHeaders = ["User-Agent": userAgent]
        var modified_parameters = parameters
        modified_parameters["device_token"] = UIDevice.current.identifierForVendor!.uuidString
        
        AF.request(url, method: .post, parameters: modified_parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let data = value as? [String: Any] else { return }
                completion?(data)
            case.failure(let error):
                #if DEBUG
                    debugPrint(error)
                #endif
            }
        }
    }
}
