//
//  UnhappyPathWeatherService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 13/07/2025.
//

import Foundation

class UnhappyPathWeatherService: WeatherService {
    func fetchWeather(geoData: GeoData, unit: UnitTemperature) async throws(WeatherError) -> WeatherData {
        throw .weatherServiceError(URLError(.badServerResponse))
    }
}
