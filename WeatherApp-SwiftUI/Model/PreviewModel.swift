//
//  PreviewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import Foundation

var weatherPreview: OpenWeatherModel = loadJSON("weatherData.json")
var forecastPreview: ForecastModel = loadJSON("forecastData.json")

func loadJSON<T: Decodable>(_ fileName: String) -> T {
    
    let data: Data
    
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("Couldn't find the \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Couldn't load the \(fileName) from main bundle: \n\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse the \(fileName) as \(T.self): \n\n\(error)")
    }
}
