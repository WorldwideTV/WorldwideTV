
import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let username = DefaultsKey<String?>("username")
    static let launchCount = DefaultsKey<Int>("launchCount")
}


class AutomaticSortManager {
    
    //let CHANNELS_URL: String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"

//    var countries: [WWCountry]?
    
    class var sharedInstance : AutomaticSortManager {
        struct Singleton {
            static let instance = AutomaticSortManager()
        }
        return Singleton.instance
    }
  
    func readStuff() {
        Defaults[.username] = "joe"
        print("launch count: \(Defaults[.launchCount])")

    }
    
    func sumLaunchCount() {
        Defaults[.launchCount]++
    }
    
    
}