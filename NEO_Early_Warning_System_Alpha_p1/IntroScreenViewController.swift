import UIKit

class IntroScreenViewController: UIViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let neoListViewController = segue.destination as? GenericListDisplayController {
      neoListViewController.viewModel = NeoListDataModel()
    }
  }
}
