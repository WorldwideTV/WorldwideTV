//
//  TVFetcherServiceRemote.swift
//  WorldwideTV
//
//  Created by Antonio Ribeiro on 14/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Alamofire
import Argo

class TVFetcherServiceRemote : TVFetcherServiceProtocol {
    
    var countries: [WWCountry]?
    
    private let channelsUrl: String = "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/channels.json"
    
    func getChannelData(onCompletion: [WWCountry]? -> ()) {
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
