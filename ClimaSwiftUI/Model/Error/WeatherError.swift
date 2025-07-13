//
//  WeatherError.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 30/06/2025.
//

import Foundation

enum WeatherError: LocalizedError {
    case geoServiceError(Error)
    case geoServiceMissingData(String)
    case weatherServiceError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .geoServiceError:
            "Error while getting location"
            
        case .geoServiceMissingData(let city):
            "No result for \(city)."
            
        case .weatherServiceError:
            "Error while getting weather"
            
        case .decodingError:
            "Error while decoding data"
        }
    }
    
    var failureReason: String?  {
        switch self {
        case .geoServiceError(let error),
                .weatherServiceError(let error),
                .decodingError(let error):
            error.localizedDescription
            
        case .geoServiceMissingData(let city) :
            "Couldn't find coordinate for \"\(city)\"."
        }
    }
}
