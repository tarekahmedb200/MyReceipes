//
//  CategoryReceipeListFetcherMock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation


class CategoryReceipeListFetcherMock : CategoryReceipeListFetcher {
    func fetchCategoryReceipeList(category: String) async throws -> [Receipe] {
        let receipeContainer : ReceipeContainer? = MockJSONDecoder.readJSONFromFile(fileName: "ReceipeList", fileType: "json")
        return receipeContainer?.receipes.filter {
            return $0.category?.caseInsensitiveCompare(category) == .orderedSame
        } ?? []
    }
}
