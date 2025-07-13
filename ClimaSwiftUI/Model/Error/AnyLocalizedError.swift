//
//  AnyLocalizedError.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 10/07/2025.
//

import Foundation

struct AnyLocalizedError: LocalizedError {
    let localizedError: LocalizedError
    
    var errorDescription: String? {
        localizedError.errorDescription
    }
    
    var failureReason: String? {
        localizedError.failureReason
    }
    
    var helpAnchor: String? {
        localizedError.helpAnchor
    }
    
    var recoverySuggestion: String? {
        localizedError.recoverySuggestion
    }
    
    var localizedDescription: String {
        localizedError.localizedDescription
    }
}
