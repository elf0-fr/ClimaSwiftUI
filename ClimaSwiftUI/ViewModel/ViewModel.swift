//
//  ViewModel.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 06/07/2025.
//

import CoreLocation
import SwiftUI

@Observable
class ViewModel {
    @ObservationIgnored private(set) var geoService: GeoService!
    @ObservationIgnored private(set) var weatherService: WeatherService!
    @ObservationIgnored private(set) var locationService: LocationService!
    
    func setServices(geoService: GeoService?, weatherService: WeatherService?, locationService: LocationService?) {
        guard let geoService, let weatherService, let locationService else {
            fatalError("Services are required")
        }
        
        self.geoService = geoService
        self.weatherService = weatherService
        self.locationService = locationService
        self.locationService.delegate = self
    }
    
    var weatherCondition: String = ""
    var temperature: Double = 0
    var city: String = ""
    
    var error: AnyLocalizedError?
    var showError: Binding<Bool> {
        Binding {
            self.error != nil
        } set: { value in
            if !value {
                self.error = nil
            }
        }
    }
    
    var searchText: String = ""
    var locationType: LocationType = .undefined {
        didSet {
            if locationType == .searchByCity {
                locationService?.stopUsingLocation()
            }
        }
    }
    
    var task: Task<(), Never>?
    
    func onSubmit() {
        let text = searchText.trimmingCharacters(in: .whitespaces)
        
        guard !text.isEmpty else {
            return
        }
        
        task?.cancel()
        task = Task {
            do throws(WeatherError) {
                guard let geoService else {
                    return // TODO: error
                }
                
                let geoData = try await geoService.fetchCoordinates(city: text)
                
                guard !Task.isCancelled else {
                    return
                }
                
                try await fetchWeather(fromGeographicData: geoData)
            } catch {
                self.error = AnyLocalizedError(localizedError: error)
                return
            }
            
            guard !Task.isCancelled else {
                return
            }
            
            searchText = ""
            locationType = .searchByCity
        }
    }
    
    func onUseCurrentLocation() {
        task?.cancel()
        task = Task {
            guard let locationService else {
                return // TODO: error
            }
            
            locationService.stopUsingLocation()
            
            guard await locationService.isAuthorized() else {
                return
            }
            
            guard !Task.isCancelled else {
                return
            }
            
            locationService.startUsingLocation()
            locationType = .currentLocation
        }
    }
    
    private func fetchWeather(fromGeographicData geoData: GeoData) async throws(WeatherError) {
        guard let weatherService else {
            return // TODO: error
        }
        
        let weatherData = try await weatherService.fetchWeather(geoData: geoData, unit: .celsius)
        
        guard !Task.isCancelled else {
            return
        }
        
        if let weather = weatherData.weather.first {
            weatherCondition = weather.icon
        } else {
            weatherCondition = "questionmark"
        }
        temperature = weatherData.main.temp
        city = weatherData.name
    }
}

extension ViewModel: LocationDelegate {
    func locationDidUpdateLocation(_ location: GeoData) {
        task?.cancel()
        task = Task {
            do throws(WeatherError) {
                try await fetchWeather(fromGeographicData: location)
            } catch {
                self.error = AnyLocalizedError(localizedError: error)
            }
        }
    }
    
    func locationDidFailWithError(_ error: UserLocationError) {
        self.error = AnyLocalizedError(localizedError: error)
    }
}
