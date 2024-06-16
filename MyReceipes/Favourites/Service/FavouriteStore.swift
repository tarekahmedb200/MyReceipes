//
//  FavouriteStore.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation
import CoreData


class FavouriteStore {
  private let context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    self.context = context
  }
}

extension FavouriteStore : FavouritesStore {
    
    func fetchFavourites() async throws -> [Receipe] {
        var receipes : [Receipe] = []
        
        let fetchRequest: NSFetchRequest<ReceipeEntity> = ReceipeEntity.fetchRequest()
        
        do {
            let receipeEntities = try self.context.fetch(fetchRequest)
            for receipe in receipeEntities {
                receipes.append(Receipe(managedObject: receipe))
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return receipes
    }
    
}
