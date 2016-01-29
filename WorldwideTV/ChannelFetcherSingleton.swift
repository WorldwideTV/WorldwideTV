//
//  ChannelFetcherSingleton.swift
//  WorldwideTV
//
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Alamofire
import Argo

class ChannelFetcherSingleton {
    
    let CHANNELS_URL : String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"

    var countries : [WWCountry]?
    
    class var sharedInstance :ChannelFetcherSingleton {
        struct Singleton {
            static let instance = ChannelFetcherSingleton()
        }
        return Singleton.instance
    }
    
    func makeRequest() {
        Alamofire.request(.GET, CHANNELS_URL)
            .responseJSON { response in
                
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                
                if let j = json {
                    let decodedWWTV = WWChannels.decode(JSON.parse(j))
                    self.countries = decodedWWTV.value!.countries

                    self.printInfo()
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