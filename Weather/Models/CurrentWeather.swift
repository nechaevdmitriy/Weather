//
//  CurrentWeather.swift
//  Weather
//
//  Created by Дмитрий  on 24.08.2021.
//

import Foundation

struct CurrentWeather {
    var city = String()
    var list = [List]()

    init?(currentWeatherData: CurrentWeatherData) {
        city = currentWeatherData.city.name
        list = currentWeatherData.list
    }
}
