//
//  CurrentWeather.swift
//  Weather
//
//  Created by Дмитрий  on 24.08.2021.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    let temperature: Double
    let temperatureDescription: String?
    let minimumTemperature: Int
    let maximumTempeature: Int
    let currentDay: String
    let feelsLike: String
    
    var temperatureString: String { "\(temperature)" }
    var minimumTemperatureString: String { "\(minimumTemperature)" }
    var maximumTemperatureString: String { "\(temperature.rounded())" }
    
    init?(currentWeatherData: CurrentWeatherData, indexPath: Int) {
        
        cityName = currentWeatherData.city.name
        temperature = currentWeatherData.list[indexPath].main.temp
        feelsLike = "\(currentWeatherData.list[indexPath].main.feelsLike)"
        temperatureDescription = ("\(currentWeatherData.list[indexPath].weather[0].weatherDescription.capitalized), ощущается как \(feelsLike)")
        minimumTemperature = Int(currentWeatherData.list[indexPath].main.tempMin)
        maximumTempeature = Int(currentWeatherData.list[indexPath].main.tempMin)
        currentDay = currentWeatherData.list[indexPath].dtTxt
    }
}
