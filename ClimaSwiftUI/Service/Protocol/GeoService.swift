//
//  GeoService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 29/06/2025.
//

import Foundation

protocol GeoService {
    func fetchCoordinates(city: String) async throws(WeatherError) -> GeoData
}
