//
//  UnhappyPathLocationService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 13/07/2025.
//

import Foundation

class UnhappyPathLocationService: LocationService {
    var delegate: LocationDelegate?
    
    func isAuthorized() async -> Bool {
        delegate?.locationDidFailWithError(UserLocationError.denied)
        return false
    }
    
    func startUsingLocation() {
        
    }
    
    func stopUsingLocation() {
        
    }
}
