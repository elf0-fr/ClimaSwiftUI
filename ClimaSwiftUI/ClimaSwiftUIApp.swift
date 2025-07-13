//
//  ClimaSwiftUIApp.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import SwiftUI

@main
struct ClimaSwiftUIApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.geoService, OpenWeatherService.shared)
                .environment(\.weatherService, OpenWeatherService.shared)
                .environment(\.locationService, UserLocationService.shared)
        }
    }
}
