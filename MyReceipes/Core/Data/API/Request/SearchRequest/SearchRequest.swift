//
//  SearchRequest.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

enum SearchRequest: RequestProtocol {
    case getMeal(name:String)
    
    var path: String {
        switch self {
        case .getMeal:
            return "/api/json/v1/1/search.php"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .getMeal(name):
            var params: [String: String] = [:]
            params["f"] = name
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
