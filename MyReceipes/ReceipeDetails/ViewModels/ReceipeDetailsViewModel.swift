//
//  ReceipeDetailsViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation
import CoreData
import UIKit

protocol ReceipeDetailsFetcher {
    func fetchReceipeDetails(id:String) async throws -> Receipe?
}

protocol ReceipeDetailsStoreProtocol {
  func save(receipe: Receipe) async throws
  func delete(entityName: String, name: String) async throws
  func fetchReceipeByName(entityName: String, name: String) async throws -> Receipe?
}

@MainActor
class ReceipeDetailsViewModel : ObservableObject {
    
    @Published var receipe: Receipe?
    @Published var receipeImage: UIImage?
    @Published var objectReceipe: Receipe
    @Published var errorMessage: String?
    @Published var isAddedToFavourite: Bool = false
    
    private var receipeDetailsFetcher: ReceipeDetailsFetcher
    private var receipeDetailsStore: ReceipeDetailsStoreProtocol
    private var imageRemoteService: ImageRemoteServiceProtocol
    private var imageLocalService: ImageLocalServiceProtocol

    
    init(objectReceipe: Receipe,receipeDetailsFetcher: ReceipeDetailsFetcher, receipeDetailsStore: ReceipeDetailsStoreProtocol, imageRemoteService: ImageRemoteServiceProtocol, imageLocalService: ImageLocalServiceProtocol) {
        self.objectReceipe = objectReceipe
        self.receipeDetailsFetcher = receipeDetailsFetcher
        self.receipeDetailsStore = receipeDetailsStore
        self.imageRemoteService = imageRemoteService
        self.imageLocalService = imageLocalService
    }
    
    func fetchReceipeDetails() async {
            do {
                if let receipe = try await self.receipeDetailsStore.fetchReceipeByName(entityName: "ReceipeEntity", name: objectReceipe.name) {
                    self.receipe = receipe
                    self.receipeImage = self.imageLocalService.fetchImage(withName: receipe.name)
                    isAddedToFavourite = true
                }else {
                    receipe = try await self.receipeDetailsFetcher.fetchReceipeDetails(id: objectReceipe.id)
                }
            } catch let error as NetworkError {
                errorMessage = error.errorDescription
            } catch {
                print(error)
                errorMessage = "Unknown error"
            }
    }
    
    func handleFavouriteSelection() async {
        if isAddedToFavourite {
            await delete()
        }else {
            await save()
        }
    }
    
    private func delete() async {
            do {
                if let receipe = receipe {
                    try await self.receipeDetailsStore.delete(entityName: "ReceipeEntity", name: receipe.name)
                    self.imageLocalService.deleteImage(withName: receipe.name)
                    isAddedToFavourite = false
                }
            } catch {
                print(error)
                errorMessage = "Unknown error"
            }
    }
    
    private func save() async {
            do {
                if let receipe = receipe {
                    try await self.receipeDetailsStore.save(receipe: receipe)
                    if let thumbRemoteURL = receipe.thumbRemoteURL ,
                       let image = try await self.imageRemoteService.fetchImage(withThumbURL: thumbRemoteURL) {
                       self.imageLocalService.saveImage(image, withName: receipe.name)
                    }
                       
                    isAddedToFavourite = true
                }
            } catch {
                print(error)
                errorMessage = "Unknown error"
            }
    }
    
}
