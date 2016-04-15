//
//  NSURL+Utils.swift
//  WorldwideTV
//
//  Created by Antonio Ribeiro on 15/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation

extension NSURL {
    
    var worldwideTVComponents: (streamUrl: String?, country: String?, channel: String?) {
        let _streamUrl = NSURLComponents(string: self.absoluteString)?.getQueryStringParameter("streamUrl")
        let _country = self.pathComponents?[1]
        let _channel = self.pathComponents?[2]
        
        return (_streamUrl, _country, _channel)
    }
    
}