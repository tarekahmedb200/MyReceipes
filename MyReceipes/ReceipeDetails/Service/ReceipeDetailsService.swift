//
//  ReceipeDetailsService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

class ReceipeDetailsService {
  private let requestManager: APIManagerProtocol

  init(requestManager: APIManagerProtocol) {
    self.requestManager = requestManager
  }
}

// MARK: - AnimalFetcher
extension ReceipeDetailsService: ReceipeDetailsFetcher {
    func fetchReceipeDetails(id: String) async throws -> Receipe? {
        let receipeContainer : ReceipeContainer? = try await self.requestManager.initRequest(with: ReceipeDetailsRequest.getReceipeDetails(id:id))
        return receipeContainer?.receipes.first 
    }
    
}


