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

struct WWCountry {
    let title: String
    let channels: [WWChannel]

}

extension WWCountry: Decodable {
    static func decode(j: JSON) -> Decoded<WWCountry> {
        return curry(WWCountry.init)
            <^> j <| "title"
            <*> j <|| "channels"

    }
}