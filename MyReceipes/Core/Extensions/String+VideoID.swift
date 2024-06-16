//
//  String+VideoID.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation


extension String {
    
    func findVideoID() -> Self? {
        if let indexOFKey : String.Index = self.firstIndex(of: "=") {
            let key = self[self.index(after: indexOFKey)...self.index(before: self.endIndex)]
            return String(key)
        }
        return nil
    }
    
    func findImagePath() -> Self? {
        if let range = self.range(of: APIConstants.host) {
            return String(self[range.upperBound...])
        }
        return nil
    }
    
    
}
