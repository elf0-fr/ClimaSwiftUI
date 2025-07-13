//
//  LocationService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 06/07/2025.
//



protocol LocationService {
    var delegate: LocationDelegate? { get set }
    
    func isAuthorized() async -> Bool
    func startUsingLocation()
    func stopUsingLocation()
}

protocol LocationDelegate {
    func locationDidUpdateLocation(_ location: GeoData)
    func locationDidFailWithError(_ error: UserLocationError)
}
