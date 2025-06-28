//
//  WeatherService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import Foundation

class WeatherService {
    let shared = WeatherService()
    
    private init() {}
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    func addUnits(toURL url: String) -> String {
        return url + "&units=metric"
    }
    
    func add(city: String, toURL url: String) -> String {
        return url + "&q=\(city)"
    }
}
