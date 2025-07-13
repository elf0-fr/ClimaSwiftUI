//
//  UserLocationError.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 01/07/2025.
//

import Foundation

enum UserLocationError: LocalizedError {
    case denied, restricted, unknown
    case failure(Error)
    
    var errorDescription: String? {
        switch self {
        case .denied:
            "Permission denied to access location."
            
        case .restricted:
            "User location access restricted."
            
        case .unknown:
            "Unknown authorization status for location"
            
        case .failure(_):
            "Failed to get location"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .denied:
            "Please allow location access in your settings."
            
        case .restricted:
            "Your location access is restricted. Please check your settings."
            
        case .unknown:
            "Please try again later."
            
        case .failure(let error):
            error.localizedDescription
        }
    }
}
