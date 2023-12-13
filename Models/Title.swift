//
//  Movie.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

extension TitleItem {
    func toTitle() -> Title {
        return Title(
            id: Int(self.id),
            media_type: self.original_title,
            original_name: self.poster_path,
            original_title: self.overview,
            poster_path: self.poster_path,
            overview: self.original_name,
            vote_count: Int(self.vote_count),
            release_date: self.release_date,
            vote_average: self.vote_average
        )
    }
}
