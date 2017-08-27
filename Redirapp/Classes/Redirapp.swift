import Foundation
import UIKit
import Alamofire


@objc public class Redirapp: NSObject {
    
    private static let baseUrl:String = "https://api.redirapp.com"
    private static let userDefaultsKey:String = "redirapp"
    private static let customerTokenUserDefaultsKey:String = "customerToken"
    
    
    private static var appId:String? = nil
    
    private static let defaults:UserDefaults = UserDefaults.init(suiteName: userDefaultsKey)!
    
    private class func getCustomerToken() -> String? {
        return Redirapp.defaults.string(forKey: Redirapp.customerTokenUserDefaultsKey)
    }
    
    private class func setCustomerToken(_ customerToken:String) {
        Redirapp.defaults.setValue(customerToken, forKey: Redirapp.customerTokenUserDefaultsKey)
    }
    
    
    public class func `init`(_ appId:String) {
        Redirapp.appId = appId
        if (getCustomerToken() == nil) { logInstallation() }
    }
    
    
    private class func logInstallation() {
        if (getCustomerToken() != nil)  { return } //Already initialized... don't log it...
        if (Redirapp.appId == nil) { return } //No app id initialized...
        Redirapp.request("/apps/\(Redirapp.appId!)/log_install") { (result) in
            Redirapp.setCustomerToken(result["customer_token"] as! String)
        }
    }
    
    public class func logPurchase(amount:Double, sku:String) {
        logPurchase(amount: amount, currency:"USD", sku: sku)
    }
    
    public class func logPurchase(amount:Double, currency:String, sku:String) {
        if (getCustomerToken() == nil)  { return } //Not initialized... don't log it...
        if (Redirapp.appId == nil) { return } //No app id initialized...
        Redirapp.request("/apps/\(Redirapp.appId!)/log_purchase", parameters: [
            "customer_token": getCustomerToken()!,
            "amount": amount,
            "currency": currency,
            "sku": sku
            ])
    }
    
    private class func request(_ path:String, parameters:[String : Any] = [:], completion: ((_ result: [String : Any]) -> Void)? = nil) {
        let url = "\(Redirapp.baseUrl)/\(path)"
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")! + " Redirapp"
        let headers:HTTPHeaders = ["User-Agent": userAgent]
        var modified_parameters = parameters
        modified_parameters["device_token"] = UIDevice.current.identifierForVendor!.uuidString
        Alamofire.request(url, method: .post, parameters: modified_parameters, headers: headers).responseJSON { response in
            if response.result.isSuccess && completion != nil {
                completion!(response.result.value as! [String : Any])
            }
        }
    }
}
