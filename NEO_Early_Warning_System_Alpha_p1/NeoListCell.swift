import UIKit

class NeoListCell: UITableViewCell {

  @IBOutlet var nameLabel: UILabel!
  
}

extension NeoListCell: ListCell {
  func populate(with item: ListItem) {
    
    guard let item = item as? Neo else {
      nameLabel.text = "error!!!"
      return
    }
    
    nameLabel.text = item.name
  }
}
