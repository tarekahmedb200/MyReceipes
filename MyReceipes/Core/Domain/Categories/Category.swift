//
//  Category.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

struct Category : Codable , Identifiable {
    
    var thumb: URL? {
        return URL(string: thumbURL)
    }
    
    var id : String
    var name : String
    var thumbURL : String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbURL = "strCategoryThumb"
    }
}


 
