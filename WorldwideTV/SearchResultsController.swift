import UIKit

class SearchResultsController: ChannelsListViewController, UISearchResultsUpdating {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.purpleColor()
    }
       
    // UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let allCountries = TVFetcherService.sharedInstance.countries else {
            return
        }
        
        let allChannels = allCountries.flatMap { $0.channels }
        let results: [WWChannel]
        
        if let searchQuery = searchController.searchBar.text where searchQuery.characters.count > 0 {
            let matchingCountries = allCountries.filter { $0.title.lowercaseString.containsString(searchQuery.lowercaseString) }
            let matchingChannels = allChannels.filter { $0.title.lowercaseString.containsString(searchQuery.lowercaseString) }
            results = matchingCountries.flatMap{ $0.channels } + matchingChannels
        } else {
            results = allChannels
        }
        
        channels = Array(Set<WWChannel>(results))
    }
}
