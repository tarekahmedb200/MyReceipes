//
//  CategoryReceipeListView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import SwiftUI

struct CategoryReceipeListView: View {
    @StateObject var viewModel :CategoryReceipeListViewModel
    
    var body: some View {
        ReceipesListView(receipes: $viewModel.filteredReceipes)
            .searchable(text: $viewModel.searchText , prompt: "Search Receipes..")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.errorMessage ?? "Default message"), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                Task {
                    await viewModel.fetchcategoryReceipeList()
                }
            })
    }
    
}

#Preview {
    CategoryReceipeListView(viewModel: CategoryReceipeListViewModel(category: "Seafood", categoryReceipeListFetcher: CategoryReceipeListFetcherMock()))
}
