//
//  OpenWeatherAPI.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import Foundation
import CoreLocation

class OpenWeatherAPI {
    
    var baseURL = "https://api.openweathermap.org/data/2.5"
    let apiKey = "325104e7c3352e849fcb468f29b137e7"
    
    //MARK: - Get Weather API
    func getCurrentWeatherAPI(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) async throws -> OpenWeatherModel {
        guard let url = URL(string: baseURL + "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") 
        else {
            fatalError("Error in URL")
        }
        let urlRequest = URLRequest(url: url)
        debugPrint("URL: \(url)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        debugPrint("Response Data== \(response)")
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error fetching data")
        }
        let decodeData = try JSONDecoder().decode(OpenWeatherModel.self, from: data)
        debugPrint("Decoded Data== \(decodeData)")
        
        return decodeData
    }
    
    func getForecastAPI(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) async throws -> ForecastModel {
        guard let url = URL(string: baseURL + "/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric")
        else {
            fatalError("Error in URL")
        }
        let urlRequest = URLRequest(url: url)
        debugPrint("URLS: \(url)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        debugPrint("Response Data== \(response)")
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error fetching data")
        }
        let decodeData = try JSONDecoder().decode(ForecastModel.self, from: data)
        debugPrint("Decoded Forecast Data == \(decodeData)")
        
        return decodeData
    }
    func epochTime(_ date: Double) -> String {

        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let unixTimestamp = date.unixTimestamp
        let dates = unixTimestamp.date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH a"
        let currentTime = formatter.string(from: dates)
        debugPrint("Currenttime == \(currentTime)")
        return String(format: "\(currentTime)")
    }

}
