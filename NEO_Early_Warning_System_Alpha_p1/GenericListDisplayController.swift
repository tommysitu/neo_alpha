import UIKit

class GenericListDisplayController: UIViewController {

  @IBOutlet var listView: UITableView!
  
  var viewModel: ListDataModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    listView.dataSource = self
    
    guard let viewModel = self.viewModel else { return }
    viewModel.updateData {
      self.listView.reloadData()
    }
  }
}

extension GenericListDisplayController: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.items.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let item = viewModel.items[indexPath.row] as ListItem
    let cell = tableView.dequeueReusableCell(withIdentifier: item.cellType.rawValue, for: indexPath) as! ListCell
    cell.populate(with: item)
    
    return cell as! UITableViewCell
  }
}
