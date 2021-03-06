import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

class CountriesViewController: UIViewController {
    
    var countries: [WWCountry]? {
        didSet {
            countriesTableView.reloadData()
            
            if let firstCountry = countries?.first {
                setChannelsForCountry(firstCountry)
            }
        }
    }
    
    var detailsViewController: ChannelsListViewController? {
        return splitViewController?.viewControllers.last as? ChannelsListViewController
    }
    
    lazy var appLogo: UIImageView               = self.makeAppLogo()
    lazy var countriesTableView: UITableView    = self.makeCountriesTableView()
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        
        view.backgroundColor = UIColor.yellowColor()
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let cell = context.nextFocusedView as? UITableViewCell,
            let indexPath = countriesTableView.indexPathForCell(cell),
            let country = countries?[indexPath.row] {
                
            setChannelsForCountry(country)
        }
    }
    
    func setupSubviews() {
        view.addSubview(appLogo)
        view.addSubview(countriesTableView)
    }
    
    func setupConstraints() {
        let views = ["countriesTableView": countriesTableView, "appLogo": appLogo]
        
        var constraints = NSLayoutConstraint.withFormat([
            "V:|-60-[appLogo(==100)]-60-[countriesTableView]-60-|",
            "H:|-90-[countriesTableView]-90-|",
            "H:[appLogo(==200)]",
        ], views: views)
        
        constraints += [appLogo.centeredInParentX()]
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeAppLogo() -> UIImageView {
        let i = UIImageView(image: UIImage(named: "App Icon - Small"))
        i.translatesAutoresizingMaskIntoConstraints = false
        
        return i
    }
    
    func makeCountriesTableView() -> UITableView {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        t.dataSource = self
        
        return t
    }
    
    func setChannelsForCountry(country: WWCountry) {
        detailsViewController?.country = country.title
        detailsViewController?.channels = country.channels
    }
    
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        let country = countries![indexPath.row]
        
        cell.textLabel?.text = country.title
        
        return cell
    }
    
}
