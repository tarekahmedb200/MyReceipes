//
//  SearchView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
            ReceipesListView(receipes: $viewModel.receipes)
            .onAppear {
                Task {
                    await viewModel.fetchSearchedReceipes()
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.errorMessage ?? "Default message"), dismissButton: .default(Text("OK")))
            }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(name: "a", searchedReceipesFetcher: SearchFetcherMock() ))
}
