import UIKit

class SearchResultsController: ChannelsListViewController, UISearchResultsUpdating {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.purpleColor()
    }
        
    // UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text where searchQuery.characters.count > 0,
              let allCountries = TVFetcherService.sharedInstance.countries else {
            return
        }
        
        let allChannels = allCountries.flatMap { $0.channels }
        let matchingCountries = allCountries.filter { $0.title.lowercaseString.containsString(searchQuery.lowercaseString) }
        let matchingChannels = allChannels.filter { $0.title.lowercaseString.containsString(searchQuery.lowercaseString) }
        
        let everything = matchingCountries.flatMap{ $0.channels } + matchingChannels
        
        if everything.count > 0 {
            channels = Array(Set<WWChannel>(everything))
        }
    }
}
