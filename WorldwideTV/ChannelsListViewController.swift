import UIKit
import Alamofire
import Argo
import AutoLayoutPlusTV

private let cellReuseIdentifier = "cellReuseIdentifier"

class ChannelsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var channels: [WWChannel]?
    
    lazy var channelsCollectionView: UICollectionView = self.makeChannelsCollectionView()
    
    override func loadView() {
        super.loadView()
        print("load view do ChannelsListViewController")
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(channelsCollectionView)
    }
    
    func setupConstraints() {
        let views = ["channelsCollectionView": channelsCollectionView]
        
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.withFormat([
            "V:|-100-[channelsCollectionView]-100-|",
            "H:|-100-[channelsCollectionView]-100-|",
            ], views: views)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeChannelsCollectionView() -> UICollectionView {
        let t = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        t.translatesAutoresizingMaskIntoConstraints = false
        t.registerClass(ChannelCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        t.delegate = self
        t.dataSource = self
        
        return t
    }
    
    func loadChannelsForCountry(country: WWCountry) {
        print("Loading channels for \(country.title)")
        self.channels = country.channels
        channelsCollectionView.reloadData()
    }

    // UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels?.count ?? 0
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        let channel = channels![indexPath.row]

        guard let cell = dequeuedCell as? ChannelCell else {
            return dequeuedCell
        }
        
        cell.titleLabel.text = channel.title
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
