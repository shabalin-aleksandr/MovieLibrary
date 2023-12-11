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

    private static func getValue(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            return nil
        }
        return dict[key] as? String
    }
}
