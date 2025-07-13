//
//  HappyPathWeatherService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 12/07/2025.
//

import Foundation

class HappyPathWeatherService: WeatherService {
    func fetchWeather(geoData: GeoData, unit: UnitTemperature) async throws(WeatherError) -> WeatherData {
        return .cupertino
    }
}
