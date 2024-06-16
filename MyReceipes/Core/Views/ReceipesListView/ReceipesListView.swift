//
//  ReceipesListView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import SwiftUI

struct ReceipesListView: View {
    
    @Binding var receipes: [Receipe]
    
    var columns: [GridItem] =
    Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200)), count: 1)
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns,alignment: .center) {
                
                ForEach(receipes) { receipe in
                    
                    NavigationLink(destination: ReceipeDetailsView(viewModel: ReceipeDetailsViewModel(
                        objectReceipe:receipe,
                        receipeDetailsFetcher: ReceipeDetailsService(requestManager: APIManager())
                        , receipeDetailsStore: ReceipeDetailsStore(context: PersistenceController.shared.container.newBackgroundContext())
                        ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()))) {
                            
                            ReceipeRowView(viewModel: ReceipeItemViewModel(receipe: receipe, imageLocalServiceProtocol: ImageLocalService()))
                                .frame(width: UIScreen.main.bounds.width)
                                .shadow(color: .gray, radius: 10, x: 0, y: 15)
                        }
                }
            }
        }
    }
    
}

#Preview {
    return ReceipesListView(receipes: .constant(Receipe.mockSearchedReceipes))
}
