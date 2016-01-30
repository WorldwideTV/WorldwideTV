//
//  ChannelFetcherSingleton.swift
//  WorldwideTV
//
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Alamofire
import Argo

class TVFetcherSingleton {
    
    let CHANNELS_URL: String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"

    var countries: [WWCountry]?
    
    class var sharedInstance : TVFetcherSingleton {
        struct Singleton {
            static let instance = TVFetcherSingleton()
        }
        return Singleton.instance
    }
    
    func makeRequest(onCompletion: [WWCountry] -> ()) {
        Alamofire.request(.GET, CHANNELS_URL)
            .responseJSON { response in
                
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                
                if let j = json {
                    let decodedWWTV = WWChannels.decode(JSON.parse(j))
                    self.countries = decodedWWTV.value!.countries

                    onCompletion(self.countries!)
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