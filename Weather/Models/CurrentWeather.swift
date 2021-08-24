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
    let temperatureDescription: String
    let minimumTemperature: Int
    let maximumTempeature: Int
    
    var temperatureString: String { "\(temperature)" }
    var minimumTemperatureString: String { "\(minimumTemperature)" }
    var maximumTemperatureString: String { "\(temperature.rounded())" }
    
    init?(currentWeatherData: CurrentWeatherData, index: Int) {
        cityName = currentWeatherData.city.name
        temperature = currentWeatherData.list[index].main.temp
        temperatureDescription = ("Ощущается как \(currentWeatherData.list[index].weather[0].weatherDescription)")
        minimumTemperature = Int(currentWeatherData.list[index].main.tempMin)
        maximumTempeature = Int(currentWeatherData.list[index].main.tempMin)
    }
}
