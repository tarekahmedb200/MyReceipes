//
//  CategoryReceipeListRequest.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation


enum CategoryReceipeListRequest: RequestProtocol {
    case getReceipeList(category:String)
    
    var path: String {
        switch self {
        case .getReceipeList:
            return "/api/json/v1/1/filter.php"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .getReceipeList(category):
            var params: [String: String] = [:]
            params["c"] = category
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
