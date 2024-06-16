//
//  Dictionary+Serialization.swift
//  MyReceipes
//
//  Created by tarek ahmed on 13/06/2024.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch  {
            print(error)
            return nil
        }
    }
    
    static func decode(data: Data) -> Self {
        do {
          return try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print(error)
            return [:]
        }
    }
    
}

