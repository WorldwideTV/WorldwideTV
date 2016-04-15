import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let channelsService = TVFetcherServiceRemote()
        let sortManager = AutomaticSortManager()
        
        // All Channels screen
        let channelsViewController = ChannelsListViewController(sortManager: sortManager)
        let countriesViewController = CountriesViewController(nibName: .None, bundle: .None)
        
        let homeViewController = UISplitViewController(nibName: .None, bundle: .None)
        homeViewController.viewControllers = [countriesViewController, channelsViewController]
        homeViewController.tabBarItem = UITabBarItem(title: "All Channels", image: .None, tag: 0)
        
        // Search screen
        let searchResultsController = SearchResultsController(channelsService: channelsService, sortManager: sortManager)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        
        let searchContainerController = UISearchContainerViewController(searchController: searchController)
        
        let searchViewNavController = UINavigationController(rootViewController: searchContainerController)
        searchViewNavController.tabBarItem = UITabBarItem(title: "Search", image: .None, tag: 0)
        
        // Settings screen
        let settingsViewController = SettingsViewController(nibName: .None, bundle: .None)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: .None, tag: 0)
        
        let viewControllers = [homeViewController, searchViewNavController, settingsViewController]
        let tabBarController = CustomTabBarController(channelsService: channelsService, viewControllers: viewControllers)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.whiteColor()
        
        sortManager.sumLaunchCount()
        sortManager.readStuff()
        
        
        return true
    }
}

