//
//  WeatherByHours.swift
//  Weather
//
//  Created by Дмитрий  on 06.10.2021.
//

import Foundation

struct WeatherByHours {
    var hour: String
    var temp: String
    var weatherImage: String
    
    init() {
        hour = ""
        temp = ""
        weatherImage = ""
    }
    
    init(hour: String, temp: String, weatherImage: String) {
        self.hour = hour
        self.temp = temp
        self.weatherImage = weatherImage
    }
}
