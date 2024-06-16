//
//  CategoriesViewModelTestCase.swift
//  MyReceipesTests
//
//  Created by tarek ahmed on 12/06/2024.
//

import XCTest
@testable import MyReceipes

final class CategoriesViewModelTestCase: XCTestCase {

    var categoriesViewModel: CategoriesViewModel!
    var searchViewModel: SearchViewModel!
    
    @MainActor
    override func setUp() {
      super.setUp()
        categoriesViewModel = CategoriesViewModel(categoriesFetcher: CategoriesFetcherMock())
    }
    
    override func tearDown() {
        categoriesViewModel = nil
        searchViewModel = nil
    }
    
    func testCategoriesCount() async {
        let expectedCategoriesCount = 14
        
        await categoriesViewModel.fetchCategories()
        let count = await categoriesViewModel.categories.count
        
        XCTAssertEqual(count, expectedCategoriesCount)
    }
    
    
    func testReceipeSearch() async {
        await MainActor.run {
            categoriesViewModel.searchText = "a"
        }
        
        searchViewModel = await SearchViewModel(name: categoriesViewModel.searchText, searchedReceipesFetcher: SearchFetcherMock())
        
        await searchViewModel.fetchSearchedReceipes()
        let searchedReceipes = await searchViewModel.receipes
        
        // Debugging: Check the count of searched recipes
        print("Searched Recipes Count: \(searchedReceipes.count)")
        
        XCTAssert(searchedReceipes.count > 0)
    }

    
    
}
