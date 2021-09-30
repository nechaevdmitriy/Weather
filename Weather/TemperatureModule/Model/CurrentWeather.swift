//
//  CurrentWeather.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

struct CurrentWeather {
    var weatherData: CurrentWeatherData
    var city: String
    var list: [WeatherList]
    var listByDays: [Substring : [WeatherList]]
    
    init?(currentWeatherData: CurrentWeatherData) {
        weatherData = currentWeatherData
        city = currentWeatherData.city.name
        list = currentWeatherData.list
        listByDays = Dictionary(grouping: weatherData.list, by: { $0.dtTxt.split(separator: " ")[0]})
    }
}
