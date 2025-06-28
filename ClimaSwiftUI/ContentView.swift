//
//  ContentView.swift
//  ClimaSwiftUI
//
//  Created by Elfo on 28/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    private let verticalSpacing: CGFloat = 18
    
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            background
            
            VStack(spacing: verticalSpacing) {
                topBar
                
                HStack {
                    Spacer()
                    
                    weatherCondition
                }
                
                Spacer()
            }
            .padding()
        }
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
                
            } label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
            }
            .buttonStyle(.plain)

            TextField("Search...", text: $searchText)
                .submitLabel(.search)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                }
        }
    }
    
    var weatherCondition: some View {
        VStack(alignment: .trailing, spacing: verticalSpacing) {
            Image(systemName: "sun.max")
                .resizable()
                .foregroundStyle(.primaryWeather)
                .scaledToFit()
                .frame(width: 120, height: 120)
            temperature
            Text("London")
                .font(.title)
        }
    }
    
    var temperature: some View {
        Group {
            Text("21")
                .fontWeight(.bold)
            + Text("°C")
                .fontWeight(.light)
        }
        .font(.system(size: 80))
    }
}

#Preview {
    ContentView()
}
