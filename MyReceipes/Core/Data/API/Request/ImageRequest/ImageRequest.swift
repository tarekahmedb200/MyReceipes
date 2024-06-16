//
//  ImageRequest.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation

enum ImageRequest: RequestProtocol {
    case getImage(thumbURL:String)
    
    var path: String {
        switch self {
        case .getImage(let thumbURL):
            return thumbURL.findImagePath() ?? ""
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
