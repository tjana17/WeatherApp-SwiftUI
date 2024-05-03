//
//  WelcomeView.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to Weather App")
                    .bold().font(.largeTitle)
                    
                Text("Please share your current location to get the weather in your area.")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .foregroundColor(.white)
            .cornerRadius(30)
            .symbolVariant(.fill)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
