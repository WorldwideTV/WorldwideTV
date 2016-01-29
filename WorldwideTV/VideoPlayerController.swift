import UIKit
import AVKit

class VideoPlayerController: UIViewController {
    
    let url: NSURL

    init(url: NSURL) {
        self.url = url
        super.init(nibName: .None, bundle: .None)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.view.frame = view.frame
        
        addChildViewController(playerController)
        view.addSubview(playerController.view)

        player.play()
    }
}
