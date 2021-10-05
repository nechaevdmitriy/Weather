//
//  ModeOfTheFirstDay.swift
//  Weather
//
//  Created by Дмитрий  on 01.10.2021.
//

import Foundation

struct WeatherOfTheFirstDay {
    var todayDate: String
    var weatherImage: String
    var currentTemp: String
    var weatherDescription: String
    
    init() {
        todayDate = ""
        weatherImage = ""
        currentTemp = ""
        weatherDescription = ""
    }
    
    init(todayDate: String, weatherImage: String, currentTemp: String, weatherDescription: String) {
        self.todayDate = todayDate
        self.weatherImage = weatherImage
        self.currentTemp = currentTemp
        self.weatherDescription = weatherDescription
    }
}
