import UIKit
import AVKit

class VideoPlayerController: UIViewController {
    
    let url: NSURL
    let channel: String
    let country: String

    init(url: NSURL, channel: String, country: String) {
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
        
        AutomaticSortManager.sharedInstance.sumChannel(self.channel, ofCountry: self.country)
        
        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.view.frame = view.frame
        
        addChildViewController(playerController)
        view.addSubview(playerController.view)

        player.play()
    }
}
