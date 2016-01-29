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

struct WWItem {
    let title: String
    let url: String
}

extension WWItem: Decodable {
    static func decode(j: JSON) -> Decoded<WWItem> {
        return curry(WWItem.init)
            <^> j <| "title"
            <*> j <| "url"

    }
}