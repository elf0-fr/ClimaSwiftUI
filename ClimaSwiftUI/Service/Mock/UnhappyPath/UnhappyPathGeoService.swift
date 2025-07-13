//
//  UnhappyPathGeoService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 13/07/2025.
//

import Foundation

class MockCodingKey: CodingKey {
    var stringValue: String
    
    required init?(stringValue: String) {
        self.stringValue = stringValue
        intValue = Int(stringValue)
    }
    
    var intValue: Int?
    
    required init?(intValue: Int) {
        self.intValue = intValue
        stringValue = String(intValue)
    }
    
    
}

class UnhappyPathGeoService: GeoService {
    func fetchCoordinates(city: String) async throws(WeatherError) -> GeoData {
        switch city.lowercased() {
        case "c":
            throw .geoServiceMissingData(city)
        case "url":
            throw .geoServiceError(URLError(.badServerResponse))
        case "network":
            throw .geoServiceError(URLError(.notConnectedToInternet))
        default:
            throw .decodingError(DecodingError.keyNotFound(MockCodingKey(stringValue: "Key")!, DecodingError.Context(codingPath: [MockCodingKey(stringValue: "Key")!], debugDescription: "Debug")))
        }
    }
}
