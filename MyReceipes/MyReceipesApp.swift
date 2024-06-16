//
//  MyReceipesApp.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import SwiftUI

@main
struct MyReceipesApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            TabView {
                CategoriesListView(viewModel: CategoriesViewModel(categoriesFetcher: CategoryService(requestManager: APIManager())))
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    
                FavouritesView(viewModel: FavouriteViewModel(favouritesStore: FavouriteStore(context: PersistenceController.shared.container.newBackgroundContext())))
                    .environment(\.managedObjectContext, PersistenceController.shared.container.newBackgroundContext())
                    .tabItem {
                        Image(systemName: "heart.circle")
                        Text("Favourites")
                    }
            }
            
        }
    }
}
