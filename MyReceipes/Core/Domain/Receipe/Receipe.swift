//
//  Receipe.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation
import SwiftyJSON

struct Receipe : Decodable , Identifiable {
    
    var thumb: URL? {
        if let thumbLocalURL = thumbRemoteURL {
            return URL(string: thumbLocalURL)
        }
        return nil
    }
    
    var source: URL? {
        if let sourceUrl = sourceURL {
            return URL(string: sourceUrl)
        }
        return nil
    }
    
    var id: String
    var name: String
    var thumbRemoteURL: String?
    var category: String?
    var area: String?
    var instructions: String?
    var youtubeURL: String?
    var sourceURL: String?
    var dateModified: String?
    var ingredientsDictionary: [String: String] = [:]
    
    enum CodingKeys : String , CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbRemoteURL = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case youtubeURL = "strYoutube"
        case sourceURL = "strSource"
        case dateModified = "dateModified"
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var intValue: Int?
        
        init?(intValue: Int) {
           return nil
        }
        
        var stringValue: String
        
        init(stringValue: String) {
            self.stringValue = stringValue
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        id = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "idMeal"))
        name = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal"))
        category = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strCategory"))
        thumbRemoteURL = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMealThumb"))
        area = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strArea"))
        instructions = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions"))
        youtubeURL = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strYoutube"))
        sourceURL = try container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: "strSource"))

        // Reflectively decode ingredients and measures
        for index in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)")
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)")
            if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty,
               !measure.isEmpty {
                ingredientsDictionary[ingredient] = measure
            }
        }
    }

}

extension Receipe {
    
    init(id:String,name:String,thumbURL:String) {
        self.id = id
        self.name = name
        self.thumbRemoteURL = thumbURL
    }
    
    init(id: String, name: String, thumbURL: String, category: String, area: String, instructions: String, youtubeURL: String, sourceURL: String, dateModified: String, ingredientsDictionary: [String : String]) {
        self.id = id
        self.name = name
        self.thumbRemoteURL = thumbURL
        self.category = category
        self.area = area
        self.instructions = instructions
        self.youtubeURL = youtubeURL
        self.sourceURL = sourceURL
        self.dateModified = dateModified
        self.ingredientsDictionary = ingredientsDictionary
    }
    
}





