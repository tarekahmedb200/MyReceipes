//
//  DataAPIManger.swift
//  MyReceipes
//
//  Created by tarek ahmed on 15/06/2024.
//

import Foundation



class DataAPIManger: APIManagerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T? {
        
        let (data,response) = try await urlSession.data(for: data.request)
        
        guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        
        return data as? T
    }
}

