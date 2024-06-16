//
//  CategoryItemView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import SwiftUI
import Kingfisher

struct CategoryItemView: View {
    
    var category: Category
    
    var body: some View {
        
        if let thumb = category.thumb {
            
            KFImage.url(thumb)
                .placeholder{
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .overlay {
                    Text(category.name)
                        .font(.system(size: 30,weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 150)
                        .background(LinearGradient(colors: [.black.opacity(0.6),.white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                }
        }
    }
}

#Preview {
    CategoryItemView(category: Category.mockCategories[0])
        .previewLayout(.sizeThatFits)
}
