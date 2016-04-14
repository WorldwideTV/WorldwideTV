
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
    
    func sumChannel(channel: String, ofCountry country: String) {
        let key = keyForCountOfChannel(channel, ofCountry: country)
        var accesses = Defaults.integerForKey(key)
        accesses += 1
        Defaults.setInteger(accesses, forKey: key)
    }
    
    func getChannelCount(channel: String, ofCountry country: String) -> Int {
        return Defaults.integerForKey(keyForCountOfChannel(channel, ofCountry: country))
    }
    
    func deleteChannelCount(channel: String, ofCountry country: String) {
        Defaults.remove(keyForCountOfChannel(channel, ofCountry: country))
    }
    
    private func keyForCountOfChannel(channel: String, ofCountry country: String) -> String {
        return "Count-" + country + "-" + channel
    }
    
    
}