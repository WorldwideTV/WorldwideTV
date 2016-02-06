
import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let username = DefaultsKey<String?>("username")
    static let launchCount = DefaultsKey<Int>("launchCount")
}


class AutomaticSortManager {
    
    class var sharedInstance : AutomaticSortManager {
        struct Singleton {
            static let instance = AutomaticSortManager()
        }
        return Singleton.instance
    }
  
    func readStuff() {
        print("launch count: \(Defaults[.launchCount])")

    }
    
    func sumLaunchCount() {
        Defaults[.launchCount]+=1
    }
    
    func sumChannel(country: String, channel: String) {
        // todo
    }
    
    func getChannelCount(country: String, channel: String) {
        // todo
    }
    
    
}