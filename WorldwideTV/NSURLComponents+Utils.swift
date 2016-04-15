//
//  NSURLComponents+Utils.swift
//  WorldwideTV
//
//  Created by Antonio Ribeiro on 15/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation

extension NSURLComponents {
    
    func getQueryStringParameter(param: String) -> String? {
        return self.queryItems?.filter{
            $0.name == param
        }.first?.value
    }
    
}