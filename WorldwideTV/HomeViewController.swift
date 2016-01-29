import UIKit
import Alamofire
import Argo


private let cellReuseIdentifier = "cellReuseIdentifier"

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let channelsUrl : String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"
    
    let channels: [(String, String)] = [
        ("RTP 1", "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp1.smil/playlist.m3u8"),
    ]
    
    lazy var channelsTableView: UITableView = self.makeChannelsTableView()
    
    override func loadView() {
        super.loadView()
        
       
        Alamofire.request(.GET, channelsUrl)
            .responseJSON { response in
                
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                

                if let j = json {
                    let decodedWWTV = WWChannels.decode(JSON.parse(j))
                    self.handleResponse(decodedWWTV)
                }
                
                self.setupView()
        }
        
    }
    
    func handleResponse(decodedWWTV : Decoded<WWChannels>) {
        //print(decodedWWTV)
        
        for country in (decodedWWTV.value?.countries)! {
            print(country.title)
            for channel in country.channels {
                print("--- \(channel.title)")
            }
        }

    }
    
    func setupView() {
        view.addSubview(channelsTableView)
        
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[channelsTableView]-100-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: .None, views: ["channelsTableView": channelsTableView])
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-100-[channelsTableView]-100-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: .None, views: ["channelsTableView": channelsTableView])
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func makeChannelsTableView() -> UITableView {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        t.delegate = self
        t.dataSource = self
        
        return t
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)
        let channel = channels[indexPath.row]
        
        if let _ = cell {
            // Cell initialised
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellReuseIdentifier)
        }
        
        cell?.textLabel?.text = channel.0
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let channel = channels[indexPath.row]
        let playerScreen = VideoPlayerController(url: NSURL(string: channel.1)!)
        
        showViewController(playerScreen, sender: self)
    }
}
