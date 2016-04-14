import UIKit
import AVKit

class VideoPlayerController: UIViewController {
    
    let sortManager: AutomaticSortManager
    let url: NSURL
    let channel: String
    let country: String

    init(sortManager: AutomaticSortManager, url: NSURL, channel: String, country: String) {
        self.sortManager = sortManager
        self.url = url
        self.channel = channel
        self.country = country
        super.init(nibName: .None, bundle: .None)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortManager.sumChannel(self.channel, ofCountry: self.country)
        
        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.view.frame = view.frame
        
        addChildViewController(playerController)
        view.addSubview(playerController.view)

        player.play()
    }
}
