//
//  CategoryService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

class CategoryService {
  private let requestManager: APIManagerProtocol

  init(requestManager: APIManagerProtocol) {
    self.requestManager = requestManager
  }
}

// MARK: - AnimalFetcher
extension CategoryService: CategoriesFetcher {
    
    func fetchCategories() async throws  -> [Category] {
       
        let categoryContainer: CategoryContainer? = try await self.requestManager.initRequest(with: CategoriesRequest.getCategories)
            
        return categoryContainer?.categories ?? []
    }
    
  
}

