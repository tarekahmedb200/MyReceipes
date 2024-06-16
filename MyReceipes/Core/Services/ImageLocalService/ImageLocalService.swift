//
//  ImageLocalService.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation
import UIKit

protocol ImageLocalServiceProtocol {
    func saveImage(_ image: UIImage, withName name: String)
    func fetchImage(withName name: String) -> UIImage?
    func deleteImage(withName name: String)
}

class ImageLocalService : ImageLocalServiceProtocol {
  
    func saveImage(_ image: UIImage, withName name: String) {
        if let imageData = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name).png")
            try? imageData.write(to: filename)
        }
    }
    
    func fetchImage(withName name: String) -> UIImage? {
        let path = getDocumentsDirectory().appendingPathComponent("\(name).png")
        return UIImage(contentsOfFile: path.path)
    }
    
    func deleteImage(withName name: String) {
        let fileManager = FileManager.default
        let path = getDocumentsDirectory().appendingPathComponent("\(name).png")
        if fileManager.fileExists(atPath: path.path) {
            do {
                try fileManager.removeItem(at: path)
                print("Image deleted successfully.")
            } catch {
                print("Error deleting image: \(error.localizedDescription)")
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
