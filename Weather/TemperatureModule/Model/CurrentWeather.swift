//
//  CurrentWeather.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

struct CurrentWeather {
    let weatherData: CurrentWeatherData
    let city: String
    let list: [WeatherList]
    let listByDays: [String : [WeatherList]]
}
