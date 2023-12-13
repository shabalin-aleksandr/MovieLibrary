//
//  Configuration.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import Foundation

struct Configuration {
    static var API_KEY: String {
        guard let apiKey = getValue(forKey: "API_KEY") else {
            fatalError("API_KEY not found in Config.plist")
        }
        return apiKey
    }

    static var baseURL: String {
        guard let baseURL = getValue(forKey: "baseURL") else {
            fatalError("baseURL not found in Config.plist")
        }
        return baseURL
    }
    
    static var imageURL: String {
        guard let imageURL = getValue(forKey: "imageURL") else {
            fatalError("imageURL not found in Config.plist")
        }
        return imageURL
    }
    
    static var YouTube_API_KEY: String {
        guard let youTubeApiKey = getValue(forKey: "YouTube_API_KEY") else {
            fatalError("YouTube_API_KEY not found in Config.plist")
        }
        return youTubeApiKey
    }
    
    static var YouTubeBaseURL: String {
        guard let youTubeBaseURL = getValue(forKey: "YouTubeBaseURL") else {
            fatalError("YouTubeBaseURL not found in Config.plist")
        }
        return youTubeBaseURL
    }
    
    static var YouTubeBaseURLForSearch: String {
        guard let youTubeBaseURL = getValue(forKey: "YouTubeBaseURLForSearch") else {
            fatalError("YouTubeBaseURLForSearch not found in Config.plist")
        }
        return youTubeBaseURL
    }

    private static func getValue(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            return nil
        }
        return dict[key] as? String
    }
}
