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
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error fetching data")
        }
        let decodeData = try JSONDecoder().decode(OpenWeatherModel.self, from: data)
        
        return decodeData
    }
    
    func getForecastAPI(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) async throws -> ForecastModel {
        guard let url = URL(string: baseURL + "/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric")
        else {
            fatalError("Error in URL")
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else {
            fatalError("Error fetching data")
        }
        let decodeData = try JSONDecoder().decode(ForecastModel.self, from: data)
        
        return decodeData
    }
    func epochTime(_ date: Double) -> String {

        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let unixTimestamp = date.unixTimestamp
        let dates = unixTimestamp.date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH a"
        let currentTime = formatter.string(from: dates)
        let timeconvert = timeConversion(time: currentTime)
        return String(format: "\(timeconvert)")
    }
    
    private func timeConversion(time: String)-> String {
        var timeString = String()
        switch time {
        case "13 PM":
            timeString = "01 PM"
        case "14 PM":
            timeString = "02 PM"
        case "15 PM":
            timeString = "03 PM"
        case "16 PM":
            timeString = "04 PM"
        case "17 PM":
            timeString = "05 PM"
        case "18 PM":
            timeString = "06 PM"
        case "19 PM":
            timeString = "07 PM"
        case "20 PM":
            timeString = "08 PM"
        case "21 PM":
            timeString = "09 PM"
        case "22 PM":
            timeString = "10 PM"
        case "23 PM":
            timeString = "11 PM"
        
        default:
            timeString = time
        }
        return timeString
    }

}
