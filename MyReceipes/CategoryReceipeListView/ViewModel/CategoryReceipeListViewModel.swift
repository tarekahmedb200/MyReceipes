//
//  CategoryReceipeListViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation

protocol CategoryReceipeListFetcher {
    func fetchCategoryReceipeList(category:String) async throws -> [Receipe]
}

@MainActor
class CategoryReceipeListViewModel : ObservableObject {
   
    @Published var filteredReceipes : [Receipe] = []
    private var categoryReceipeListFetcher : CategoryReceipeListFetcher
    var receipes : [Receipe] = []
    private var category:String
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
    
    init(category:String,categoryReceipeListFetcher : CategoryReceipeListFetcher) {
        self.category = category
        self.categoryReceipeListFetcher = categoryReceipeListFetcher
    }
    
    func fetchcategoryReceipeList() async {
            do {
                receipes = try await self.categoryReceipeListFetcher.fetchCategoryReceipeList(category: category)
                filteredReceipes = receipes
            }catch let error as NetworkError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = error.localizedDescription
            }
    }
    
    
    
}
