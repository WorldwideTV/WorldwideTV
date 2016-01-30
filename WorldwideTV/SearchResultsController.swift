import UIKit

class SearchResultsController: UIViewController, UISearchResultsUpdating {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.purpleColor()
    }
    
    // UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text where searchQuery.characters.count > 0 else {
            return
        }

        print("search query: \(searchQuery)")
    }

}