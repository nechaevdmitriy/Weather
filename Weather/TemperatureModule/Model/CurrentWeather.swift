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
}
