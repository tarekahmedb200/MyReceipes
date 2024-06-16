//
//  ReceipeDetailsStore.swift
//  MyReceipes
//
//  Created by tarek ahmed on 13/06/2024.
//

import Foundation
import CoreData

class ReceipeDetailsStore {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - ReceipeDetailsStore
extension ReceipeDetailsStore : ReceipeDetailsStoreProtocol {
    
    func delete(entityName: String, name: String) async throws {
        if let receipeEntity = try await fetchReceipeEntityByName(entityName: entityName, name: name) {
            self.context.delete(receipeEntity)
            try context.save()
        }
    }
    
    func fetchReceipeByName(entityName: String, name: String) async throws -> Receipe?
    {
        if let receipeEntity = try await fetchReceipeEntityByName(entityName: entityName, name: name) as? ReceipeEntity {
            return Receipe(managedObject: receipeEntity)
        } else {
            return nil
        }
    }
    
    private func fetchReceipeEntityByName(entityName: String, name: String) async throws -> NSManagedObject?
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        let result = try context.fetch(fetchRequest)
        return result.first
    }
    
    func save(receipe: Receipe) async throws {
        var receipe = receipe
        receipe.toManagedObject(context: context)
        try context.save()
    }
    
}
