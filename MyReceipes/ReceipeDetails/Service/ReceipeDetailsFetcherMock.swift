//
//  ReceipeDetailsFetcherMock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation


class ReceipeDetailsFetcherMock : ReceipeDetailsFetcher {
    
    func fetchReceipeDetails(id: String) async throws -> Receipe? {
        let receipeContainer : ReceipeContainer? = MockJSONDecoder.readJSONFromFile(fileName: "ReceipeDetails", fileType: "json")
        let receipe = receipeContainer?.receipes.first(where: { $0.id == id })
        return receipe
    }
    
}
