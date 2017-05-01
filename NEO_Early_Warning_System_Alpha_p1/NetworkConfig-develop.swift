import Foundation

let baseUrl = "api.nasa.gov"

struct NetworkConfig: NetworkConfigProtocol {
//  static let baseUrl = "creagh.com"
  static let baseUrl = "api.nasa.gov"
  static let serverProtocol:ServerProtocol = .https
  static let apiKey = "BBmr7ggYLfN2ClaYTPngBHZgQvR7NlwE6LszMb4u"
}
