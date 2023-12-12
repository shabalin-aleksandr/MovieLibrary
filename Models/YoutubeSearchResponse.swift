//
//  YoutubeSearchResponse.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 12.12.2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
