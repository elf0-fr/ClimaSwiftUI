//
//  UserLocationService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 01/07/2025.
//

import Foundation
import CoreLocation
import SwiftUI

class UserLocationService: NSObject {
    enum AuthorizationStatus {
        case notDetermined
        case authorized
        case notAuthorized(error: UserLocationError)
        
        var isNotDetermined: Bool {
            switch self {
            case .notDetermined:
                return true
            default:
                return false
            }
        }
    }
    
    static let shared = UserLocationService()
    
    private override init() {
        super.init()
        
        manager.delegate = self
    }
    
    private var manager = CLLocationManager()
    private var useUserLocation: Bool = false
    
    var delegate: LocationDelegate?
    
    private func checkForAuthorization() -> AuthorizationStatus {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return .authorized
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            return .notDetermined
            
        case .denied:
            return .notAuthorized(error: .denied)
            
        case .restricted:
            return .notAuthorized(error: .restricted)
            
        @unknown default:
            return .notAuthorized(error: .unknown)
        }
    }
}

extension UserLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard useUserLocation else { return }
        
        switch checkForAuthorization() {
        case .notAuthorized(error: let error):
            delegate?.locationDidFailWithError(error)
            
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard useUserLocation else { return }
        
        if let location = locations.last?.coordinate {
            delegate?.locationDidUpdateLocation(GeoData(lat: location.latitude, lon: location.longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        guard useUserLocation else { return }
        
        delegate?.locationDidFailWithError(.failure(error))
    }
}

extension UserLocationService: LocationService {
    func isAuthorized() async -> Bool {
        var status = checkForAuthorization()
        
        while status.isNotDetermined {
            await Task.yield()
            status = checkForAuthorization()
        }
        
        switch status {
        case .authorized:
            return true
            
        case .notAuthorized(error: let error):
            delegate?.locationDidFailWithError(error)
            return false
            
        default:
            return false
        }
    }
    
    func startUsingLocation() {
        let status = manager.authorizationStatus
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return
        }
        
        useUserLocation = true
        manager.startUpdatingLocation()
    }
    
    func stopUsingLocation() {
        useUserLocation = false
        manager.stopUpdatingLocation()
    }
}
