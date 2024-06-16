//
//  MockJSONDecoder.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation

enum MockJSONDecoder {
    
    static func readJSONFromFile<T: Decodable>(fileName: String, fileType: String) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let user = try JSONDecoder().decode(T.self, from: data)
                return user
            } catch {
                print(error)
            }
        }
        
        return nil
    }
}

