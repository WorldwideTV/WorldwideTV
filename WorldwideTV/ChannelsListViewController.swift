import UIKit
import Alamofire
import Argo
import AutoLayoutPlusTV

private let cellReuseIdentifier = "cellReuseIdentifier"

class ChannelsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let channels: [(String, String)] = [
        ("RTP 1", "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp1.smil/playlist.m3u8"),
    ]
    
    lazy var channelsCollectionView: UICollectionView = self.makeChannelsCollectionView()
    
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
    
    func loadChannelsForCountry(country: String) {
        
    }

    // UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        
        guard let cell = dequeuedCell as? ChannelCell else {
            return dequeuedCell
        }
        
        cell.titleLabel.text = "HELLO"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
