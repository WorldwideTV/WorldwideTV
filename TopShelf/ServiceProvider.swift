//
//  ServiceProvider.swift
//  TopShelf
//
//  Created by Antonio Ribeiro on 14/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import TVServices


class ServiceProvider: NSObject, TVTopShelfProvider {

    static let tvFetcher = TVFetcherServiceRemote()
    static let hitManager = AutomaticSortManager()
    
    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .Sectioned
    }

    var topShelfItems: [TVContentItem] {
        var parsedFinished = false
        
        var topShelfCategories: [TVContentItem] = [TVContentItem]()
        var channels = [WWTopShelfChannel]()
        
        ServiceProvider.tvFetcher.getChannelData { countries in
            
            if let wwcountries = countries  {
                
                wwcountries.forEach { wwcountry in
                    
                    wwcountry.channels.forEach { wwchannel in
                        
                        let numberOfViews: Int = ServiceProvider.hitManager.getChannelCount(wwchannel.title, ofCountry: wwcountry.title)
                        
                        channels.append(
                            WWTopShelfChannel(channel: wwchannel, country: wwcountry.title, numberOfHits: numberOfViews)
                        )
                    }
                }
                
                // if there are less than 10 channels, give back all. Otherwise give the first 10
                let channelsForTopShelf = channels.sort {
                    return $0.0.numberOfHits > $0.1.numberOfHits
                    }[0...(channels.count > 10 ? 9 : channels.count)]
                
                var currentCountry: String?
                var currentSectionID: TVContentIdentifier?
                var currentSection: TVContentItem?
                channelsForTopShelf.forEach { channel in
                    if currentCountry != channel.country {
                        currentCountry = channel.country
                        currentSectionID = TVContentIdentifier(identifier: "country-" + channel.country, container: nil)!
                        currentSection = TVContentItem(contentIdentifier: currentSectionID!)!
                        currentSection!.title = channel.country
                        currentSection?.topShelfItems = [TVContentItem]()
                        topShelfCategories.append(currentSection!)
                    }
                    
                    let channelIdentifier = TVContentIdentifier(identifier: "channel-" + channel.channel.title, container: nil)!
                    let channelItem = TVContentItem(contentIdentifier: channelIdentifier)!
                    channelItem.imageURL = NSURL(string: channel.channel.thumbnail)
                    
                    currentSection?.topShelfItems?.append(channelItem)
                }
            }
            
            parsedFinished = true
        }
        
        while (!parsedFinished) {
            sleep(1)
        }
        
        return topShelfCategories
    }

}

