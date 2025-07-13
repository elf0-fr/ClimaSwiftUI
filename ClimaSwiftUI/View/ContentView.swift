//
//  ContentView.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    private let verticalSpacing: CGFloat = 18
    
    @State private var viewModel = ViewModel()
    
    @Environment(\.geoService) private var geoService
    @Environment(\.weatherService) private var weatherService
    @Environment(\.locationService) private var userLocationService

    //MARK: - Views
    
    var body: some View {
        ZStack {
            background
            
            VStack(spacing: verticalSpacing) {
                topBar
                
                HStack {
                    Spacer()
                   
                    if viewModel.locationType != .undefined {
                        weatherConditionView
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.setServices(
                geoService: geoService,
                weatherService: weatherService,
                locationService: userLocationService
            )
        }
        .alert(
            isPresented: viewModel.showError,
            error: viewModel.error,
            actions: errorActionsView(error:),
            message: errorMessageView(error:)
        )
    }
    
    var background: some View {
        GeometryReader { geometry in
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(
                    width: geometry.size.width + 100,
                    height: geometry.size.height,
                    alignment: .trailing
                )
        }
        .ignoresSafeArea(.keyboard)
    }
    
    var topBar: some View {
        TopBarHStack {
            Button {
                viewModel.onUseCurrentLocation()
            } label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
            }
            .buttonStyle(.plain)

            TextField("Search...", text: $viewModel.searchText)
                .submitLabel(.search)
                .onSubmit(viewModel.onSubmit)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                }
        }
    }
    
    var weatherConditionView: some View {
        VStack(alignment: .trailing, spacing: verticalSpacing) {
            Image(systemName: viewModel.weatherCondition)
                .resizable()
                .foregroundStyle(.primaryWeather)
                .scaledToFit()
                .frame(width: 120, height: 120)
            temperatureView
            cityNameView
        }
    }
    
    var temperatureView: some View {
        Group {
            Text(Int(viewModel.temperature).description)
                .fontWeight(.bold)
            + Text("°C")
                .fontWeight(.light)
        }
        .font(.system(size: 80))
    }
    
    var cityNameView: some View {
        HStack {
            if viewModel.locationType == .currentLocation {
                Image(systemName: "location.fill")
                    .font(.title)
            }
            Text(viewModel.city)
                .font(.title)
        }
    }
    
    //MARK: - Error views
    
    @ViewBuilder
    func errorActionsView(error: AnyLocalizedError) -> some View {
        switch error.localizedError {
        case is WeatherError:
            EmptyView()
            
        case is UserLocationError:
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                 Text("Settings")
             }
             
             Button("OK") {}
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func errorMessageView(error: AnyLocalizedError) -> some View {
        switch error.localizedError {
        case is WeatherError:
            Text(error.failureReason ?? "Unknown error")
            
        case is UserLocationError:
            Text(error.recoverySuggestion ?? "Unknown error")
            
        default:
            EmptyView()
        }
    }
}

#Preview("Happy path") {
    ContentView()
        .environment(\.geoService, HappyPathGeoService())
        .environment(\.weatherService, HappyPathWeatherService())
        .environment(\.locationService, HappyPathLocationService())
}

#Preview("UP GeoService") {
    ContentView()
        .environment(\.geoService, UnhappyPathGeoService())
        .environment(\.weatherService, HappyPathWeatherService())
        .environment(\.locationService, HappyPathLocationService())
}

#Preview("UP WeatherService") {
    ContentView()
        .environment(\.geoService, HappyPathGeoService())
        .environment(\.weatherService, UnhappyPathWeatherService())
        .environment(\.locationService, HappyPathLocationService())
}

#Preview("UP LocationService") {
    ContentView()
        .environment(\.geoService, HappyPathGeoService())
        .environment(\.weatherService, HappyPathWeatherService())
        .environment(\.locationService, UnhappyPathLocationService())
}
