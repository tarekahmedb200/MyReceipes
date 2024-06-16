//
//  ImageRemoteService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation
import UIKit


protocol ImageRemoteServiceProtocol {
    func fetchImage(withThumbURL thumbUrl: String) async throws -> UIImage?
}

class ImageRemoteService {
  private let requestManager: APIManagerProtocol

  init(requestManager: APIManagerProtocol) {
    self.requestManager = requestManager
  }
}

extension ImageRemoteService: ImageRemoteServiceProtocol {
    
    func fetchImage(withThumbURL thumbUrl: String) async throws -> UIImage? {
        if let imageData : Data? = try await self.requestManager.initRequest(with: ImageRequest.getImage(thumbURL: thumbUrl)) ,
           let imageData = imageData,
           let image = UIImage(data: imageData) {
            return image
        }
        
        return nil
    }
    
}
