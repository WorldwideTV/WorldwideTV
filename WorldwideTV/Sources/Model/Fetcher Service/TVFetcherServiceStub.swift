//
//  TVFetcherServiceStub.swift
//  WorldwideTV
//
//  Created by Antonio Ribeiro on 14/04/16.
//  Copyright © 2016 WorldwideTV. All rights reserved.
//

import Foundation

class TVFetcherServiceStub: TVFetcherService {
    
    lazy var countries: [WWCountry]? = [
        WWCountry(title: "Portugal", channels: [
            WWChannel(title:"RTP 1", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc1.jpg", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp1.smil/playlist.m3u8"),
            WWChannel(title:"RTP 2", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc3.gif", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp2.smil/playlist.m3u8"),
            WWChannel(title:"RTP 3", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc1.jpg", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/rtpn_5ch64h264.stream/chunklist.m3u8")
            ]),
        WWCountry(title: "United Kindgom", channels: [
            WWChannel(title:"UK 1", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc2.gif", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp1.smil/playlist.m3u8"),
            WWChannel(title:"UK 2", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc1.jpg", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp2.smil/playlist.m3u8")
            ]),
        WWCountry(title: "Spain", channels: [
            WWChannel(title:"Spain 1", thumbnail: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc1.jpg", url: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp1.smil/playlist.m3u8"),
            WWChannel(title:"Spain 2", thumbnail: "http://rtp-pull-live.hls.adaptive.level3.net/liverepeater/smil:rtp2.smil/playlist.m3u8", url: "https://raw.githubusercontent.com/WorldwideTV/TVChannels/master/images/bbc1.jpg")
            ])
    ]
    
    func getChannelData(onCompletion: [WWCountry]? -> ()) {
        onCompletion(self.countries)
    }
    
}