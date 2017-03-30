import Foundation

class NeoListDataModel: ListDataModel {
  
  var items: [ListItem] = []
  
  func updateData(with success: @escaping ()->()) {
    let request = URLRequest(url: URL(with: .fetchNeos))
    
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil);
    session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
      
      var json:Dictionary<String,AnyObject>?
      if error == nil {
        json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JsonBlobData
      }
      
      self.items = parse(forPeriod: json)
      
      DispatchQueue.main.async {
        success()
      }
    }.resume()
  }
}
