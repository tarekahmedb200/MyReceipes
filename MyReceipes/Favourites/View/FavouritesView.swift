//
//  FavouritesView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import SwiftUI
import CoreData

struct FavouritesView: View {
    
    @StateObject var viewModel: FavouriteViewModel
    
    var body: some View {
        
        NavigationView(content: {
            ReceipesListView(receipes: $viewModel.filteredReceipes)
                .searchable(text: $viewModel.searchText , prompt: "Search..")
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Favourites")
                .onAppear(perform: {
                    Task {
                        await viewModel.fetchFavourites()
                    }
                })
        })
        
    }
}

#Preview {
    FavouritesView(viewModel: FavouriteViewModel(favouritesStore: FavouriteStore(context: PersistenceController.preview.container.viewContext)))
}
