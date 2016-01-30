import UIKit

class HomeViewController: UISplitViewController {
    
    lazy var loadingOverlay: UIView = self.makeLoadingOverlay()
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        
        // Load countries/channels and then: loadingOverlay.removeFromSuperview()
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
