//
//  ReceipeDetailsView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import SwiftUI
import Kingfisher

struct ReceipeDetailsView: View {
    
    enum Segment: String, CaseIterable, Identifiable {
        case ingridents = "Ingridents"
        case instructions = "Instructions"
        case video = "Video"
        var id: String { self.rawValue }
    }
    
    @StateObject var viewModel: ReceipeDetailsViewModel
    
    @State private var selectedSegment: Segment = .ingridents
    
    var body: some View {
        
        VStack(spacing:0) {
            
            headerView
            
            Spacer()
            
            VStack {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack {
                        
                        titleView
                        
                        Picker("Options", selection: $selectedSegment) {
                            ForEach(Segment.allCases) { segment in
                                Text(segment.rawValue).tag(segment)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        
                        switch selectedSegment {
                        case .ingridents:
                            ingridentsView
                        case .instructions:
                            instructionsView
                        case .video:
                            videoView
                        }
                        
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Alert"), message: Text(viewModel.errorMessage ?? "Default message"), dismissButton: .default(Text("OK")))
        }
        .task {
            await viewModel.fetchReceipeDetails()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
            }
        }
    }
    
    @ViewBuilder
    var headerView : some View {
        if let receipe = viewModel.receipe {
            
            Group {
                if let receipeImage = viewModel.receipeImage {
                    Image(uiImage: receipeImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .ignoresSafeArea()
                } else if let thumb = receipe.thumb {
                    
                    KFImage.url(thumb)
                        .placeholder{
                            ProgressView()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .ignoresSafeArea()
                }
            }.overlay(alignment: .bottomTrailing) {
                Button {
                    Task {
                        await viewModel.handleFavouriteSelection()
                    }
                    
                } label: {
                    if viewModel.isAddedToFavourite {
                        Image(systemName:"heart.fill")
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .font(.title)
                    }else {
                        Image(systemName:"heart")
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                }
                .frame(width: 50,height: 50)
                .background(.white)
                .clipShape(Circle())
                .padding()
                .animation(.interactiveSpring(duration: 2), value: viewModel.isAddedToFavourite)
                .shadow(color: .black, radius: 20)
            }
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        if let receipe = viewModel.receipe {
            Text(receipe.name)
                .font(.system(.title,design: .serif))
                .foregroundStyle(.black)
            
            HStack {
                Text(receipe.area ?? "No Area")
                Text(receipe.category ?? "No Category")
            }
            .font(.title2)
        }
    }
    
    @ViewBuilder
    var ingridentsView: some View {
        if let receipe = viewModel.receipe {
            ForEach(receipe.ingredientsDictionary.keys.sorted(), id: \.self) { key in
                HStack {
                    Text(key)
                    Spacer()
                    Text(receipe.ingredientsDictionary[key, default: ""])
                }
                .padding(5)
                .font(.title3)
                .foregroundStyle(.black)
            }
        }
    }
    
    @ViewBuilder
    var instructionsView: some View {
        if let receipe = viewModel.receipe {
            VStack(spacing:0) {
                Text("Instrctions:")
                    .font(.title2)
                
                Spacer()
                
                Text(receipe.instructions ?? "No Instruction")
                    .lineLimit(nil)
                    .foregroundColor(.black)
                    .font(.system(size: 25,design: .serif))
            }
        }
    }
    
    @ViewBuilder
    var videoView: some View {
        if let receipe = viewModel.receipe {
            VStack {
                
                if let youtubeURL = receipe.youtubeURL,
                   let videoID = youtubeURL.findVideoID() {
                    YouTubeView(videoID: videoID)
                        .frame(height: 300)
                        .cornerRadius(10, antialiased: true)
                } else {
                    ProgressView()
                }
                
                if let source = receipe.source {
                    Link("For More Info", destination:source)
                }
            }
        }
    }
}

#Preview {
    ReceipeDetailsView(viewModel: ReceipeDetailsViewModel(
        objectReceipe: Receipe.mockSearchedReceipes.first!,
        receipeDetailsFetcher: ReceipeDetailsFetcherMock(),
        receipeDetailsStore: ReceipeDetailsStore(context:
                                                    PersistenceController.preview.container.viewContext)
        ,imageRemoteService: ImageRemoteService(requestManager: DataAPIManger()), imageLocalService: ImageLocalService()))
}



