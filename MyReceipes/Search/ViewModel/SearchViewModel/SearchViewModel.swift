//
//  SearchViewModel.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

protocol SearchedReceipesFetcher {
    func fetchSearchedReceipes(name:String)  async throws -> [Receipe]
}

@MainActor
class SearchViewModel : ObservableObject {
    
    @Published var receipes = [Receipe]()
    @Published var showAlert = false
    @Published var errorMessage: String? {
        didSet {
            showAlert = errorMessage != nil
        }
    }
   
    private var searchedReceipesFetcher : SearchedReceipesFetcher
    private var name : String
    
    init(name:String,searchedReceipesFetcher : SearchedReceipesFetcher) {
        self.searchedReceipesFetcher = searchedReceipesFetcher
        self.name = name
    }
    
    func fetchSearchedReceipes() async {
        do {
            receipes = try await self.searchedReceipesFetcher.fetchSearchedReceipes(name: name)
        } catch let error as NetworkError {
            errorMessage = error.errorDescription
        } catch {
            print(error)
            errorMessage = "Unknown error"
        }
    }
    
    
}

