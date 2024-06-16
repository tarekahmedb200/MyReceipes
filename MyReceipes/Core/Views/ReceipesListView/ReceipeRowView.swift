//
//  ReceipeRowView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import SwiftUI
import Kingfisher


struct ReceipeRowView: View {
    
    var viewModel: ReceipeItemViewModel
    
    var body: some View {
        
        HStack(alignment: .center,spacing: 15) {
            
            if let receipeImage = viewModel.receipeImage {
                Image(uiImage: receipeImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100,height:100)
                    .clipShape(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    )
            } else if let thumb = viewModel.receipe.thumb {
                KFImage.url(thumb)
                    .placeholder{
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100,height:100)
                    .clipShape(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    )
            }
            
            Text(viewModel.receipe.name)
                .font(.system(size: 20,weight: .medium))
                .foregroundStyle(.black)
            
            Spacer()
        }
        .clipShape(Capsule())
        .overlay(
            Capsule().stroke(Color.gray, lineWidth: 0.1)
        )
        .padding(.horizontal)
        
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    ReceipeRowView(viewModel: ReceipeItemViewModel(receipe: Receipe.mockSearchedReceipes.first!, imageLocalServiceProtocol: ImageLocalService()))
}
