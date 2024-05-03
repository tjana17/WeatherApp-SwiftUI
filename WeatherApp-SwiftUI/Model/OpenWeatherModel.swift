//
//  OpenWeatherModel.swift
//  WeatherApp-SwiftUI
//
//  Created by DB-MBP-023 on 12/04/24.
//

import Foundation

struct OpenWeatherModel: Decodable {
    
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
    var name: String
    var coord: CoordinateResponse
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }

    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
}


// MARK: - Forecast Model
struct ForecastModel: Decodable {
    var cod: String
    var message, cnt: Int
    var list: [List]
    var city: City
}

// MARK: - City
struct City: Decodable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Decodable {
    var lat, lon: Double
}

// MARK: - List
struct List: Decodable {
    var dt: Int
    var main: MainClass
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var visibility: Int
    var pop: Double
    var sys: Sys
    var dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Decodable {
    var all: Int
}

// MARK: - MainClass
struct MainClass: Decodable {
    var temp, feelsLike, tempMin, tempMax: Double
    var pressure, seaLevel, grndLevel, humidity: Int
    var tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    var pod: Pod
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

enum Description: String, Decodable {
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum Icon: String, Decodable {
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
}

enum MainEnum: String, Decodable {
    case clouds = "Clouds"
}

// MARK: - Wind
struct Wind: Decodable {
    var speed: Double
    var deg: Int
    var gust: Double
}
