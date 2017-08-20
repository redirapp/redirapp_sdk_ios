import Foundation
import UIKit
import Alamofire


class Redirapp {
    
    private static var appId:String? = nil
    
    private static let defaults:UserDefaults = UserDefaults.init(suiteName: "redirapp")!
    private static let userDefaultsCustomerTokenKey:String = "customerToken"
    
    private class func getCustomerToken() -> String? {
        return Redirapp.defaults.string(forKey: Redirapp.userDefaultsCustomerTokenKey)
    }
    
    class func `init`(appId:String) {
        
        if (Redirapp.appId != nil) { return }
        
        Redirapp.appId = appId
        
        if (getCustomerToken() == nil) { logInstallation() }
        
        
        
        
    }
    
    class func logInstallation() {
        if (Redirapp.appId == nil)  { return }
        
        
        
    }
    
    class func test() {
        print("teste")
        
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")! + " Redirapp"
        print(userAgent)
        UserDefaults.standard.register(defaults: ["UserAgent": userAgent])
        
        let url = "http://127.0.0.1:3000/test"
        
        let headers: HTTPHeaders = [
            "User-Agent": userAgent
        ]
        
        
        Alamofire.request(url, headers: headers).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        
        /*
         
         let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
         guard error == nil else {
         print(error!)
         return
         }
         guard let data = data else {
         print("Data is empty")
         return
         }
         
         let json = try! JSONSerialization.jsonObject(with: data, options: [])
         print(json)
         }
         task.resume()
         */
    }
    
    
}
