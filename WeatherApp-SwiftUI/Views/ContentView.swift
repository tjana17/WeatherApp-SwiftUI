//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @State var weatherResponse: OpenWeatherModel?
    @State var forecastResponse: ForecastModel?
    var weatherManager = OpenWeatherAPI()
    
    var body: some View {
        VStack {
            //Check weather location is on
            if let location = locationManager.location {
                if let weather = weatherResponse, let forecast = forecastResponse {
                    WeatherView(weather: weather, forecast: forecast)
                } else {
                    ProgressView()
                        .task {
                            do {
                                weatherResponse = try await weatherManager.getCurrentWeatherAPI(location.latitude, location.longitude)
                                
                                forecastResponse = try await weatherManager.getForecastAPI(location.latitude, location.longitude)
                            } catch {
                                print("Error getting the weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
