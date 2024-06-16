//
//  Receipe+CoreData.swift
//  MyReceipes
//
//  Created by tarek ahmed on 13/06/2024.
//

import Foundation
import CoreData


// MARK: - UUIDIdentifiable
extension Receipe  {
    
    init(managedObject: ReceipeEntity) {
      self.id = managedObject.id ?? ""
      self.name = managedObject.name ?? "No Name"
      self.category = managedObject.category ?? "No Category"
      self.area = managedObject.area
      self.instructions = managedObject.instructions
      self.youtubeURL = managedObject.youtubeURL
      self.sourceURL = managedObject.sourceURL
      self.dateModified = managedObject.dataModified ?? ""
        self.thumbRemoteURL = managedObject.thumbRemoteURL
      if let ingridentsData = managedObject.ingridents {
          self.ingredientsDictionary = Dictionary.decode(data: ingridentsData)
      }
  }

 @discardableResult
  mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> ReceipeEntity {
      let persistedValue = ReceipeEntity.init(context: context)
      persistedValue.id = self.id 
      persistedValue.name = self.name
      persistedValue.category = self.category
      persistedValue.area = self.area
      persistedValue.instructions = self.instructions
      persistedValue.youtubeURL = self.youtubeURL
      persistedValue.sourceURL = self.sourceURL
      persistedValue.dataModified = self.dateModified
      persistedValue.ingridents = self.ingredientsDictionary.encode()
      persistedValue.thumbRemoteURL = self.thumbRemoteURL
      return persistedValue
  }
}
