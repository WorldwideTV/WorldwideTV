import UIKit

class CustomTabBarController: UITabBarController {
    
    let channelsService: TVFetcherService
    
    lazy var loadingOverlay: UIView = self.makeLoadingOverlay()
    
    init(channelsService: TVFetcherService, viewControllers: [UIViewController]?) {
        self.channelsService = channelsService
        super.init(nibName: .None, bundle: .None)
        
        self.viewControllers = viewControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func setupSubviews() {
        view.addSubview(loadingOverlay)
    }
    
    func setupConstraints() {
        let views = ["loadingOverlay": loadingOverlay]
        
        let constraints = NSLayoutConstraint.withFormat([
            "V:|[loadingOverlay]|",
            "H:|[loadingOverlay]|",
            ], views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeLoadingOverlay() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.blackColor()
        
        let startupImage = UIImageView(image: UIImage(named: "startup")!)
        startupImage.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(startupImage)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        v.addSubview(indicator)
        
        var constraints: [NSLayoutConstraint] = []
        constraints += startupImage.likeParent()
        constraints += indicator.centeredInParent()
        
        NSLayoutConstraint.activateConstraints(constraints)
        
        return v
    }
    
    func fetchData() {
        channelsService.getChannelData { countries in
            if let obtainedCountries = countries where obtainedCountries.count > 0 {
                self.loadingOverlay.removeFromSuperview()
                
                if let homeViewController = self.viewControllers?.first as? UISplitViewController,
                    let countriesViewController = homeViewController.viewControllers.first as? CountriesViewController {
                        countriesViewController.countries = countries
                }
            } else {
                self.showErrorMessage()
            }
        }
    }
    
    func showErrorMessage() {
        let retryAction = UIAlertAction(title: "Retry", style: .Default, handler: { action in
            self.fetchData()
        })
        
        let alert = UIAlertController(title: "Error", message: "Failed to load channels list.", preferredStyle: .Alert)
        alert.addAction(retryAction)
        
        presentViewController(alert, animated: true, completion: .None)
    }
    
}