//
//  RequestProtocol.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var params: [String: Any] {
        [:]
    }
    
    var urlParams: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var request:  URLRequest {
        
        get throws {
            
            guard !path.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw NetworkError.invalidURL
            }
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            
            if !urlParams.isEmpty {
                components.queryItems = urlParams.map {
                    URLQueryItem(name: $0, value: $1)
                }
            }
            
            guard let url = components.url else {
                throw NetworkError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = requestType.rawValue
            
            if !headers.isEmpty {
                urlRequest.allHTTPHeaderFields = headers
            }
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if !params.isEmpty {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            }
            
            return urlRequest
        }
    }
}

