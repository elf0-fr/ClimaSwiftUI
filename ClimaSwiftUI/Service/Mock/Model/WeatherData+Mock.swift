//
//  WeatherData+Mock.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 12/07/2025.
//

import Foundation

extension WeatherData {
    static var cupertino = WeatherData(
        weather: [Weather(id: 800)],
        main: Main(temp: 24),
        name: "Cupertino"
    )
}
