//
//  Service+EnvironmentValue.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 06/07/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var geoService: GeoService? = nil
    @Entry var weatherService: WeatherService? = nil
    @Entry var locationService: LocationService? = nil
}
