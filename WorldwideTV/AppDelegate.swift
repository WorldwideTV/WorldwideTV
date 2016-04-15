import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private static let sortManager = AutomaticSortManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let channelsService = TVFetcherServiceRemote()
        
        // All Channels screen
        let channelsViewController = ChannelsListViewController(sortManager: AppDelegate.sortManager)
        let countriesViewController = CountriesViewController(nibName: .None, bundle: .None)
        
        let homeViewController = UISplitViewController(nibName: .None, bundle: .None)
        homeViewController.viewControllers = [countriesViewController, channelsViewController]
        homeViewController.tabBarItem = UITabBarItem(title: "All Channels", image: .None, tag: 0)
        
        // Search screen
        let searchResultsController = SearchResultsController(channelsService: channelsService, sortManager: AppDelegate.sortManager)
        
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        
        let searchContainerController = UISearchContainerViewController(searchController: searchController)
        
        let searchViewNavController = UINavigationController(rootViewController: searchContainerController)
        searchViewNavController.tabBarItem = UITabBarItem(title: "Search", image: .None, tag: 0)
        
        // Settings screen
        let settingsViewController = SettingsViewController(nibName: .None, bundle: .None)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: .None, tag: 0)
        
        
        let tabBarController = CustomTabBarController(channelsService: channelsService)
        tabBarController.viewControllers = [homeViewController, searchViewNavController, settingsViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.whiteColor()
        
        AppDelegate.sortManager.sumLaunchCount()
        AppDelegate.sortManager.readStuff()
        
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        NSLog("Received open thru url")
        
        let components = url.worldwideTVComponents
        
        if  let streamUrl = components.streamUrl,
            let channel = components.channel,
            let country = components.country {
            
            let videoController = VideoPlayerController(sortManager: AppDelegate.sortManager, url: NSURL(string: streamUrl)!, channel: channel, country: country)
            
            window?.rootViewController?.presentViewController(videoController, animated: false, completion: .None)
            
            return true
            
        } else {
            return false
        }
        
    }
    
}

