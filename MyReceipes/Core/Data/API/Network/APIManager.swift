//
//  APIManager.swift
//  MyReceipes
//
//  Created by tarek ahmed on 11/06/2024.
//

import Foundation

protocol APIManagerProtocol {
    func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T?
}

class APIManager: APIManagerProtocol {
    
    private let urlSession: URLSession
    
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T? {
        
        let (data,response) = try await urlSession.data(for: data.request)
        
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        
        let decoded: T = try parser.parse(data: data)
        
        return decoded
    }
}

// MARK: - Returns Data Parser
extension APIManager {
    var parser: DataParserProtocol {
        return DataParser()
    }
}


