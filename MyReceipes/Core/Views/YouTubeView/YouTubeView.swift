//
//  YouTubeView.swift
//  MyReceipes
//
//  Created by tarek ahmed on 14/06/2024.
//

import Foundation
import WebKit
import SwiftUI

struct YouTubeView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.load(URLRequest(url: youtubeURL))
    }
}
