//
//  WeatherData.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 30/06/2025.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let id: Int
    
    var icon: String {
        switch id {
        case 200...232:
            "cloud.bolt.rain"
            
        case 300...321:
            "cloud.drizzle"
            
        case 500...531:
            "cloud.rain"
            
        case 600...622:
            "cloud.snow"
            
        case 701...781:
            "cloud.fog"
            
        case 800:
            "sun.max"
            
        case 801...804:
            "cloud"
            
        default:
            "cloud"
        }
    }
}

struct Main: Decodable {
    let temp: Double

}
