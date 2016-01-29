//
//  Category.swift
//  WorldwideTV
//
//  Created by Cesar Ferreira on 29/01/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation
import Argo
import Curry

struct WWCategory {
    let title: String
    let items: [WWItem]

}

extension WWCategory: Decodable {
    static func decode(j: JSON) -> Decoded<WWCategory> {
        return curry(WWCategory.init)
            <^> j <| "title"
            <*> j <|| "items"

    }
}