//
//  FavouriteViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation


protocol FavouritesStore {
    func fetchFavourites() async throws -> [Receipe]
}

@MainActor
class FavouriteViewModel : ObservableObject {
    
    @Published var filteredReceipes : [Receipe] = []
    private var favouritesStore : FavouritesStore
    var receipes : [Receipe] = []
    private var errorMessage:String?
    @Published var searchText : String = "" {
        didSet {
            if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                filteredReceipes = receipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }else {
                filteredReceipes = receipes
            }
        }
    }
    
    init(favouritesStore: FavouritesStore) {
        self.favouritesStore = favouritesStore
    }
   
    func fetchFavourites() async {
            do {
                receipes = try await self.favouritesStore.fetchFavourites()
                filteredReceipes = receipes
            } catch let error as NetworkError {
                errorMessage = error.errorDescription
            } catch {
                print(error)
                errorMessage = "Unknown error"
            }
    }
    
    
    
}




