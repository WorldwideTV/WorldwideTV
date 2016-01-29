import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let countries: [String] = [
        "Portugal",
        "United Kingdom",
    ]
    
    lazy var countriesTableView: UITableView = self.makeCountriesTableView()
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        
        view.backgroundColor = UIColor.redColor()
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
        t.delegate = self
        t.dataSource = self
        
        return t
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)
        let country = countries[indexPath.row]
        
        if let _ = cell {
            // Cell initialised
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellReuseIdentifier)
        }
        
        cell?.textLabel?.text = country
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let country = countries[indexPath.row]
        let playerScreen = VideoPlayerController(url: NSURL(string: country)!)
        
        showViewController(playerScreen, sender: self)
    }
}
