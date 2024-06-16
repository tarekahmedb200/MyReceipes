//
//  Persistance.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation
import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for i in 0..<3 {
      var receipe = Receipe.mockSearchedReceipes[i]
      receipe.toManagedObject(context: viewContext)
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()

  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "MyReceipes")
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
      
    container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
      
    container.viewContext.automaticallyMergesChangesFromParent = true
  }

  static func save() {
    let context =
    PersistenceController.shared.container.newBackgroundContext()
    guard context.hasChanges else { return }

    do {
      try context.save()
    } catch {
      fatalError("""
        \(#file), \
        \(#function), \
        \(error.localizedDescription)
      """)
    }
  }
}

