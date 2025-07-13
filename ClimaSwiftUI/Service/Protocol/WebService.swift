//
//  WebService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 30/06/2025.
//

import Foundation

protocol WebService {
    func getRequest(forURL urlString: String, parameters: [String:String]) async throws -> Data
}

extension WebService {
    func getRequest(forURL urlString: String, parameters: [String:String]) async throws -> Data {
        var urlComponents = URLComponents(string: urlString)
        
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
