import Foundation

typealias UrlString = String

enum ServerProtocol {
  case http, https
}

protocol NetworkConfigProtocol {
  static var baseUrl: String { get }
  static var serverProtocol: ServerProtocol { get }
  static var apiKey: String { get }
}

extension URL {
  init(with apiDefinition: Api) {
    print(apiDefinition.url)
    self.init(string: apiDefinition.url)!
  }
}
