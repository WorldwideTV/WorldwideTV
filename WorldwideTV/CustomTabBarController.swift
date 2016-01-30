import UIKit

class CustomTabBarController: UITabBarController {
    
    lazy var loadingOverlay: UIView = self.makeLoadingOverlay()
    
    var countries: [WWCountry]?
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        
        // Load countries/channels:
        TVFetcherSingleton.sharedInstance.makeRequest { countries in
            self.countries = countries
            self.loadingOverlay.removeFromSuperview()
            
            if let homeViewController = self.viewControllers?.first as? UISplitViewController,
               let countriesViewController = homeViewController.viewControllers.first as? CountriesViewController {
                countriesViewController.countries = countries
            }
            
        }
    }
    
    func setupSubviews() {
        view.addSubview(loadingOverlay)
    }
    
    func setupConstraints() {
        let views = ["loadingOverlay": loadingOverlay]
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints += NSLayoutConstraint.withFormat([
            "V:|[loadingOverlay]|",
            "H:|[loadingOverlay]|",
            ], views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeLoadingOverlay() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.blackColor()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        v.addSubview(indicator)
        
        var constraints: [NSLayoutConstraint] = []
        constraints += indicator.centeredInParent()
        
        NSLayoutConstraint.activateConstraints(constraints)
        
        return v
    }
    
}