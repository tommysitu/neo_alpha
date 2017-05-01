import Foundation

class NeoListDataModel: ListDataModel {
  
  var items: [ListItem] = []
  var title = "Near Earth Objects"
  
  func updateData(with success: @escaping ()->()) {
    let request = URLRequest(url: URL(with: .fetchNeos))
    
//    "http://localhost:8500"
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    config.connectionProxyDictionary = [AnyHashable: Any]()
    
    config.connectionProxyDictionary?["HTTPEnable"] = true
    config.connectionProxyDictionary?["HTTPProxy"] = "localhost"
    config.connectionProxyDictionary?["HTTPPort"] = 8500
    config.connectionProxyDictionary?["HTTPSEnable"] = true
    config.connectionProxyDictionary?["HTTPSProxy"] = "localhost"
    config.connectionProxyDictionary?["HTTPSPort"] = 8500

//    let sessionConfiguration = URLSessionConfiguration.defaultSessionConfiguration()
    
    
//    let session = URLSession(configuration: config, delegate: NSURLSessionPinningDelegate(), delegateQueue: nil);
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    
    session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
      
      var json:Dictionary<String,AnyObject>?
      if error == nil {
        json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JsonBlobData
      }
      
      print(json)
      
      self.items = parse(forPeriod: json)
      
      DispatchQueue.main.async {
        success()
      }
    }.resume()
  }
}


import Foundation
import Security

class NSURLSessionPinningDelegate: NSObject, URLSessionDelegate {
  
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
    
    // Adapted from OWASP https://www.owasp.org/index.php/Certificate_and_Public_Key_Pinning#iOS
    
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
      if let serverTrust = challenge.protectionSpace.serverTrust {
        var secresult = SecTrustResultType.invalid
        let status = SecTrustEvaluate(serverTrust, &secresult)
        
        if(errSecSuccess == status) {
          if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
            let serverCertificateData = SecCertificateCopyData(serverCertificate)
            let data = CFDataGetBytePtr(serverCertificateData);
            let size = CFDataGetLength(serverCertificateData);
            let cert1 = NSData(bytes: data, length: size)
            let file_der = Bundle.main.path(forResource: "certificate", ofType: "cer")
            
            if let file = file_der {
              if let cert2 = NSData(contentsOfFile: file) {
                if cert1.isEqual(to: cert2 as Data) {
                  completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                  return
                }
              }
            }
          }
        }
      }
    }
    
    // Pinning failed
    completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
  }
  
}
