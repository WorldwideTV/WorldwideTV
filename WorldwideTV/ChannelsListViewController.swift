import UIKit
import Alamofire
import Argo
import AutoLayoutPlusTV
import Kingfisher

private let cellReuseIdentifier = "cellReuseIdentifier"

class ChannelsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var channels: [WWChannel]? {
        didSet {
            print("New list of channels obtained")
            channelsCollectionView.reloadData()
        }
    }
    
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
        cell.logoView.kf_setImageWithURL(NSURL(string: channel.thumbnail)!)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath {
            print("CHANNEL: \(channels![indexPath.row].title)")
        }
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let channel = channels![indexPath.row]
        
        if let url = NSURL(string: channel.url) {
            let videoController = VideoPlayerController(url: url)
            presentViewController(videoController, animated: true, completion: .None)
        }
    }
}
