//
//  NetworkError.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

public enum NetworkError: LocalizedError {
    
  case invalidServerResponse
  case invalidURL
    
  public var errorDescription: String? {
    switch self {
    case .invalidServerResponse:
      return "The server returned an invalid response."
    case .invalidURL:
      return "URL string is malformed."
    }
  }
    
}
