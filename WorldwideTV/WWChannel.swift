//
//  WWItem.swift
//  WorldwideTV
//
//  Created by Cesar Ferreira on 29/01/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Argo
import Curry

struct WWChannel {
    let title: String
    let thumbnail: String
    let url: String
}

extension WWChannel: Decodable {
    static func decode(j: JSON) -> Decoded<WWChannel> {
        return curry(WWChannel.init)
            <^> j <| "title"
            <*> j <| "thumbnail"
            <*> j <| "url"

    }
}