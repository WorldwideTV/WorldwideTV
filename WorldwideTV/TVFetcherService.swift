//
//  TVFetcherServiceProtocol.swift
//  WorldwideTV
//
//  Created by Antonio Ribeiro on 14/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation

class TVFetcherService {
    
    class var sharedInstance : TVFetcherServiceProtocol {
        struct Singleton {
            static let instance = TVFetcherServiceRemote()
        }
        return Singleton.instance
    }
}

protocol TVFetcherServiceProtocol {
    
    var countries: [WWCountry]? { get }
    
    func getChannelData(onCompletion: [WWCountry]? -> ())
}