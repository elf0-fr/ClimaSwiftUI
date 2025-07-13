//
//  WeatherService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import Foundation

protocol WeatherService {
    func fetchWeather(geoData: GeoData, unit: UnitTemperature) async throws(WeatherError) -> WeatherData
}
