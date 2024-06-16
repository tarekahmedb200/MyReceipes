//
//  CategoriesView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import SwiftUI

struct CategoriesListView: View {
    @StateObject var viewModel : CategoriesViewModel
    
    var columns: [GridItem] =
    Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                if viewModel.isSearching {
                    SearchView(viewModel: SearchViewModel(name: viewModel.searchText, searchedReceipesFetcher: SearchService(requestManager: APIManager())))
                } else {
                    
                    ScrollView {
                        LazyVGrid(columns: columns,alignment: .center) {
                            Section(header:
                                        HStack {
                                Text("Categories").font(.title)
                                    .padding()
                                
                                Spacer()
                            }
                                    
                            ) {
                                ForEach(viewModel.categories) { category in
                                    NavigationLink {
                                        CategoryReceipeListView(viewModel: CategoryReceipeListViewModel(category: category.name, categoryReceipeListFetcher: CategoryReceipeListService(requestManager: APIManager())))
                                    } label: {
                                        CategoryItemView(category: category)
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                }
                
                
            }
            .searchable(text: $viewModel.searchText ,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Receipes..")
            .navigationTitle("Search..")
            .navigationBarTitleDisplayMode(.automatic)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.errorMessage ?? "Default message"), dismissButton: .default(Text("OK")))
            }
            
        }
        
        
    }
}

#Preview {
    CategoriesListView(viewModel: CategoriesViewModel(categoriesFetcher: CategoriesFetcherMock()))
}
