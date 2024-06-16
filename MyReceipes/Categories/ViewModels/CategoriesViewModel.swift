//
//  CategoriesViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

protocol CategoriesFetcher {
    func fetchCategories()  async throws -> [Category]
}

@MainActor
class CategoriesViewModel : ObservableObject {
    
    @Published var categories = [Category]()
    @Published var showAlert = false
    @Published var errorMessage: String? {
        didSet {
            showAlert = errorMessage != nil
        }
    }
    @Published var searchText : String = ""
    
    var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var categoriesFetcher : CategoriesFetcher
    
    init(categoriesFetcher: CategoriesFetcher) {
        self.categoriesFetcher = categoriesFetcher
        Task {
            await fetchCategories()
        }
    }
    
    func fetchCategories() async {
        do {
          categories = try await self.categoriesFetcher.fetchCategories()
        } catch let error as NetworkError {
            errorMessage = error.errorDescription
        } catch {
            print(error)
            errorMessage = "Unknown error"
        }
    }
    
    
}
