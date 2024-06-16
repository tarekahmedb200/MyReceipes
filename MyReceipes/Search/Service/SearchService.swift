//
//  SearchService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation


class SearchService {
  private let requestManager: APIManagerProtocol

  init(requestManager: APIManagerProtocol) {
    self.requestManager = requestManager
  }
}

// MARK: - AnimalFetcher
extension SearchService: SearchedReceipesFetcher {
    
    func fetchSearchedReceipes(name:String) async throws  -> [Receipe] {
    
        let receipeContainer : ReceipeContainer? = try await self.requestManager.initRequest(with: SearchRequest.getMeal(name: name))
            
        return receipeContainer?.receipes ?? []
    }
    
}

