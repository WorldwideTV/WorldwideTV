import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // All Channels screen
        let channelsViewController = ChannelsListViewController(nibName: .None, bundle: .None)
        let countriesViewController = CountriesViewController(nibName: .None, bundle: .None)
        
        let homeViewController = UISplitViewController(nibName: .None, bundle: .None)
        homeViewController.viewControllers = [countriesViewController, channelsViewController]
        homeViewController.tabBarItem = UITabBarItem(title: "All Channels", image: .None, tag: 0)
        
        // Search screen
        let searchResultsController = SearchResultsController(nibName: .None, bundle: .None)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        
        let searchContainerController = UISearchContainerViewController(searchController: searchController)
        
        let searchViewNavController = UINavigationController(rootViewController: searchContainerController)
        searchViewNavController.tabBarItem = UITabBarItem(title: "Search", image: .None, tag: 0)
        
        // Settings screen
        let settingsViewController = SettingsViewController(nibName: .None, bundle: .None)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: .None, tag: 0)
        
        
        let tabBarController = CustomTabBarController(nibName: .None, bundle: .None)
        tabBarController.viewControllers = [homeViewController, searchViewNavController, settingsViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.whiteColor()
        
        AutomaticSortManager.sharedInstance.sumLaunchCount()
        AutomaticSortManager.sharedInstance.readStuff()
        
        
        return true
    }
}

