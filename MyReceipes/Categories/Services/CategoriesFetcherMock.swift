//
//  CategoriesFetcherMock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation


class CategoriesFetcherMock : CategoriesFetcher {
    func fetchCategories() async throws -> [Category] {
        
        let categoryContainer : CategoryContainer? = MockJSONDecoder.readJSONFromFile(fileName: "Categories", fileType: "json")
        return categoryContainer?.categories ?? []
    }
    
}
