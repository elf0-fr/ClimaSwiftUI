//
//  OpenWeatherService.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 06/07/2025.
//

import Foundation

class OpenWeatherService: WebService {
    static let shared = OpenWeatherService()
    
    private init() {}
    
    private let geoServiceBaseURLString = "http://api.openweathermap.org/geo/1.0/direct"
    private let weatherBaseURLString = "https://api.openweathermap.org/data/2.5/weather"
}

extension OpenWeatherService: GeoService {
    func fetchCoordinates(city: String) async throws(WeatherError) -> GeoData {
        let parameters = [
            "appid": key,
            "q": city
        ]
        
        let data: Data
        do {
            data = try await getRequest(forURL: geoServiceBaseURLString, parameters: parameters)
        } catch {
            throw WeatherError.geoServiceError(error)
        }
        
        let geoDataArray: [GeoData]
        do {
            geoDataArray = try JSONDecoder().decode([GeoData].self, from: data)
        } catch {
            throw WeatherError.decodingError(error)
        }
        
        guard let geoData = geoDataArray.first else {
            throw .geoServiceMissingData(city)
        }
        
        return geoData
    }
}

extension OpenWeatherService: WeatherService {
    
    func fetchWeather(geoData: GeoData, unit: UnitTemperature) async throws(WeatherError) -> WeatherData  {
        let unitString: String
        switch unit {
        case .celsius:
            unitString = "metric"
        case .fahrenheit:
            unitString = "imperial"
        default:
            unitString = "standard"
        }
        
        let parameters = [
            "appid": key,
            "units": unitString,
            "lat": geoData.lat.description,
            "lon": geoData.lon.description
        ]
        
        let data: Data
        do {
            data = try await getRequest(forURL: weatherBaseURLString, parameters: parameters)
        } catch {
            throw .weatherServiceError(error)
        }
        
        
        let decoder = JSONDecoder()
        let weatherData: WeatherData
        do {
             weatherData = try decoder.decode(WeatherData.self, from: data)
        } catch {
            throw .decodingError(error)
        }
        
        return weatherData
    }
}
