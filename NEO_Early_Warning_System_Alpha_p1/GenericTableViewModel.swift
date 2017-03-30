import Foundation

protocol ListDataModel {
  var items: [ListItem] { get }
  var title: String { get set }
  func updateData(with success: @escaping ()->())
  
}
