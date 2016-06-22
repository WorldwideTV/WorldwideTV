import UIKit
import Alamofire
import Argo
import AutoLayoutPlusTV
import Kingfisher

private let cellReuseIdentifier = "cellReuseIdentifier"

class ChannelsListViewController: UIViewController {
    
    let sortManager: AutomaticSortManager
    var country: String!
    
    var channels: [WWChannel]? {
        didSet {
            channelsCollectionView.reloadData()
            
            if channels?.count > 0 {
                channelsCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .None, animated: false)
            }
        }
    }
    
    lazy var channelsCollectionView: UICollectionView = self.makeChannelsCollectionView()
    
    init(sortManager: AutomaticSortManager) {
        self.sortManager = sortManager
        
        super.init(nibName: .None, bundle: .None)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(channelsCollectionView)
    }
    
    func setupConstraints() {
        let views = ["channelsCollectionView": channelsCollectionView]
        
        let constraints = NSLayoutConstraint.withFormat([
            "V:|[channelsCollectionView]|",
            "H:|[channelsCollectionView]|",
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
}

extension ChannelsListViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels?.count ?? 0
    }
    
}

extension ChannelsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        let channel = channels![indexPath.row]
        
        guard let cell = dequeuedCell as? ChannelCell else {
            return dequeuedCell
        }
        
        cell.titleLabel.text = channel.title
        cell.logoView.kf_setImageWithURL(NSURL(string: channel.thumbnail)!)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        //if let indexPath = context.nextFocusedIndexPath {
        //print("CHANNEL: \(channels![indexPath.row].title)")
        //}
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let channel = channels![indexPath.row]
        
        if let url = NSURL(string: channel.url) {
            let videoController = VideoPlayerController(sortManager: sortManager, url: url, channel: channel.title, country: self.country)
            print("I TAPPED on \(channel.title)")
            presentViewController(videoController, animated: true, completion: .None)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 80
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 90, bottom: 60, right: 90)
    }

}
