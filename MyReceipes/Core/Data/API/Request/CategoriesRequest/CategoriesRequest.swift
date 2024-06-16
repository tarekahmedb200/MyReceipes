//
//  CategoriesRequest.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

enum CategoriesRequest: RequestProtocol {
    case getCategories
    
    var path: String {
        "/api/json/v1/1/categories.php"
    }
    
    var requestType: RequestType {
        .GET
    }
}
