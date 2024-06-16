//
//  ReceipeDetailsViewModelTestCase.swift
//  MyReceipesTests
//
//  Created by tarek ahmed on 14/06/2024.
//

import XCTest
@testable import MyReceipes

final class ReceipeDetailsViewModelTestCase: XCTestCase {
 
    var viewModel: ReceipeDetailsViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testAddNewReceipeToFavourites() async {
        
        let newReceipe = Receipe(id: "52771", name: "Spicy Arrabiata Penne", thumbURL: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg")
        
        viewModel = await ReceipeDetailsViewModel(
            objectReceipe:newReceipe,
            receipeDetailsFetcher: ReceipeDetailsFetcherMock(),
            receipeDetailsStore: ReceipeDetailsStore(context: PersistenceController.preview.container.viewContext)
            ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()
        )
        
        await viewModel.fetchReceipeDetails()
        //add to favourites
        await viewModel.handleFavouriteSelection()
    
        let isAddedToFavourite = await viewModel.isAddedToFavourite
        
        XCTAssert(isAddedToFavourite == true)
    }
    
    
    func testRemoveExistingReceipeFromFavourites() async {
        
        viewModel = await ReceipeDetailsViewModel(
            objectReceipe:Receipe.mockSearchedReceipes.first!,
            receipeDetailsFetcher: ReceipeDetailsFetcherMock(),
            receipeDetailsStore: ReceipeDetailsStore(context: PersistenceController.preview.container.viewContext)
            ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()
        )
        
        await viewModel.fetchReceipeDetails()
        //add to favourites
        await viewModel.handleFavouriteSelection()
    
        let isAddedToFavourite = await viewModel.isAddedToFavourite
        
        XCTAssert(isAddedToFavourite == false)
    }
    

    func testAddNewReceipeToFavouritesThenRemove() async {
        
        let newReceipe = Receipe(id: "52771", name: "Spicy Arrabiata Penne", thumbURL: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg")
        
        viewModel = await ReceipeDetailsViewModel(
            objectReceipe:newReceipe,
            receipeDetailsFetcher: ReceipeDetailsFetcherMock(),
            receipeDetailsStore: ReceipeDetailsStore(context: PersistenceController.preview.container.viewContext)
            ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()
        )
        
        await viewModel.fetchReceipeDetails()
        
        //add to favourites
        await viewModel.handleFavouriteSelection()
        let isAddedToFavourite = await viewModel.isAddedToFavourite
        XCTAssert(isAddedToFavourite == true)
        
        //remove from favourites
        await viewModel.handleFavouriteSelection()
        let isRemovedFromFavourite = await !viewModel.isAddedToFavourite
        XCTAssert(isRemovedFromFavourite == true)
    }
    

}
