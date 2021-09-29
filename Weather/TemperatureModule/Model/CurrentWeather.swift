//
//  CurrentWeather.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import Foundation

struct CurrentWeather {
    var city = String()
    var list: [WeatherList]
    var listByDays: Dictionary<Optional<Substring>, Array<Array<WeatherList>.Element>>
    
    
    init?(currentWeatherData: CurrentWeatherData) {
        city = currentWeatherData.city.name
        list = currentWeatherData.list
        listByDays = Dictionary(grouping: currentWeatherData.list, by: { $0.dtTxt.split(separator: " ").first })
    }
}
