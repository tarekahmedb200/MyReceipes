//
//  ReceipeDetailsRequest.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

enum ReceipeDetailsRequest: RequestProtocol {
    case getReceipeDetails(id:String)
    
    var path: String {
        switch self {
        case .getReceipeDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .getReceipeDetails(id):
            var params: [String: String] = [:]
            params["i"] = id
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
