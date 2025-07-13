//
//  HappyPathGeoService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 12/07/2025.
//

import Foundation

class HappyPathGeoService: GeoService {
    func fetchCoordinates(city: String) async throws(WeatherError) -> GeoData {
        return .cupertino
    }
}
