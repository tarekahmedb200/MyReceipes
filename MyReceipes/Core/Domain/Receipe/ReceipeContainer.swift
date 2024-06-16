//
//  ReceipeContainer.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation
import SwiftyJSON

struct ReceipeContainer : Decodable {
    
    var receipes : [Receipe] = []
    
    enum CodingKeys: String, CodingKey {
        case receipes = "meals"
    }
    
}
