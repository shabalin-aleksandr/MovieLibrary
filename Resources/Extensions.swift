//
//  Extensions.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        let words = self.lowercased().split(separator: " ")
        let capitalizedWords = words.enumerated().map { index, word -> String in
            if index < 2 {
                return word.prefix(1).uppercased() + word.dropFirst()
            } else {
                return String(word)
            }
        }
        return capitalizedWords.joined(separator: " ")
    }
}

