//
//  SearchFetcherMock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

class SearchFetcherMock : SearchedReceipesFetcher {
    func fetchSearchedReceipes(name: String) async throws -> [Receipe] {
        let receipeContainer : ReceipeContainer? = MockJSONDecoder.readJSONFromFile(fileName: "ReceipeList", fileType: "json")
        return receipeContainer?.receipes.filter {
            $0.name.contains(name)
        } ?? []
    }
}
