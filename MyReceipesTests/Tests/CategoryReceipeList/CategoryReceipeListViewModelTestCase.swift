//
//  CategoryReceipeListViewModelTestCase.swift
//  MyReceipesTests
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation

import XCTest
@testable import MyReceipes

final class CategoryReceipeListViewModelTestCase: XCTestCase {

    var categoryReceipeListViewModel: CategoryReceipeListViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        categoryReceipeListViewModel = nil
    }
    
    func testReceipeCount() async {
        
        categoryReceipeListViewModel = await CategoryReceipeListViewModel(category: "Seafood", categoryReceipeListFetcher: CategoryReceipeListFetcherMock())
        
        await categoryReceipeListViewModel.fetchcategoryReceipeList()
        
        let count = await categoryReceipeListViewModel.filteredReceipes.count
        
        XCTAssert(count > 0)
    }
    
    
    func testReceipeSearch() async {
        
        categoryReceipeListViewModel = await CategoryReceipeListViewModel(category: "Seafood", categoryReceipeListFetcher: CategoryReceipeListFetcherMock())
        
        await categoryReceipeListViewModel.fetchcategoryReceipeList()
        
        await MainActor.run {
            categoryReceipeListViewModel.searchText = "a"
        }
        
        let filteredReceipes = await categoryReceipeListViewModel.filteredReceipes
        
        XCTAssert(filteredReceipes.count > 0)
    }

    
    
}
