//
//  ChannelFetcherSingleton.swift
//  WorldwideTV
//
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Alamofire
import Argo

class TVFetcherService {
    
    let CHANNELS_URL: String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"
    
    let USE_REMOTE_LIST: Bool = true

    var countries: [WWCountry]?
    
    private var channelsUrl : String {
        return self.USE_REMOTE_LIST ? CHANNELS_URL :
            NSBundle.mainBundle().URLForResource("channels", withExtension: "json")!.absoluteString
    }
    
    class var sharedInstance : TVFetcherService {
        struct Singleton {
            static let instance = TVFetcherService()
        }
        return Singleton.instance
    }
    
    func getChannelData(onCompletion: [WWCountry]? -> ()) {
        let channelsUrl = self.channelsUrl
        NSLog("Getting channels from \(channelsUrl)")
        Alamofire.request(.GET, channelsUrl)
            .responseJSON { response in
                let json = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                
                if let j = json {
                    let decodedWWTV = WWChannels.decode(JSON.parse(j))
                    self.countries = decodedWWTV.value?.countries

                    onCompletion(self.countries)
                } else {
                    onCompletion(.None)
                }
        }
    }
    
    func printInfo() {
        
        for country in countries! {
            print(country.title)
            for channel in country.channels {
                print("--- \(channel.title)")
            }
        }
    }
    
}