//
//  RequestResult.swift
//  WorldwideTV
//
//  Created by Cesar Ferreira on 29/01/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Argo
import Curry

struct WWChannels {
    let countries: [WWCountry]
}

extension WWChannels: Decodable {
    static func decode(j: JSON) -> Decoded<WWChannels> {
        return curry(WWChannels.init)
            <^> j <|| "countries"

    }
}