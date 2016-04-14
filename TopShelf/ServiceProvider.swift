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
    
    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .Sectioned
    }

    var topShelfItems: [TVContentItem] {
        // Create an array of TVContentItems.
        return []
    }

}

