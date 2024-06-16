//
//  CategoryReceipeListService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation
    
class CategoryReceipeListService {
  private let requestManager: APIManagerProtocol

  init(requestManager: APIManagerProtocol) {
    self.requestManager = requestManager
  }
}

// MARK: - AnimalFetcher
extension CategoryReceipeListService: CategoryReceipeListFetcher {
    func fetchCategoryReceipeList(category: String) async throws -> [Receipe] {
        let receipeContainer : ReceipeContainer? = try await self.requestManager.initRequest(with: CategoryReceipeListRequest.getReceipeList(category: category))
            
        return receipeContainer?.receipes ?? []
    }
    
}



