//
//  HappyPathLocationService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 12/07/2025.
//

import Foundation

class HappyPathLocationService: LocationService {
    var delegate: LocationDelegate?
    
    func isAuthorized() async -> Bool {
        return true
    }
    
    func startUsingLocation() {
        delegate?.locationDidUpdateLocation(.cupertino)
    }
    
    func stopUsingLocation() {
        
    }
}
