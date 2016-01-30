import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

class CountriesViewController: UIViewController, UITableViewDataSource {
    
    var countries: [WWCountry]? {
        didSet {
            countriesTableView.reloadData()
        }
    }
    
    var detailsViewController: ChannelsListViewController? {
        return splitViewController?.viewControllers.last as? ChannelsListViewController
    }
    
    var homeViewController: HomeViewController? {
        return splitViewController as? HomeViewController
    }
    
    lazy var countriesTableView: UITableView = self.makeCountriesTableView()
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        
        view.backgroundColor = UIColor.redColor()
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        let cell = context.nextFocusedView as! UITableViewCell
        let indexPath = countriesTableView.indexPathForCell(cell)!
        let country = countries![indexPath.row]
        let channelsViewController = detailsViewController!
        
        channelsViewController.loadChannelsForCountry(country)
    }
    
    func setupSubviews() {
        view.addSubview(countriesTableView)
    }
    
    func setupConstraints() {
        let views = ["countriesTableView": countriesTableView]
        
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.withFormat([
            "V:|[countriesTableView]|",
            "H:|[countriesTableView]|",
            ], views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeCountriesTableView() -> UITableView {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        t.dataSource = self
        
        return t
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)
        let country = countries![indexPath.row]
        
        if let _ = cell {
            // Cell initialised
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellReuseIdentifier)
        }
        
        cell?.textLabel?.text = country.title
        
        return cell!
    }
    
}
