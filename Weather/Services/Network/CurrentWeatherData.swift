//
//  CurrentWeather.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

struct CurrentWeatherData: Codable {
    let list: [WeatherList]
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
}

struct WeatherList: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility, pop
        case dtTxt = "dt_txt"
        case rain
    }
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
