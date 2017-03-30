import Foundation

typealias CellIdentifier = String

protocol ListItem {
  var cellType: SubMenuCellType { get }
}

protocol ListCell {
  func populate(with item:ListItem)
}
