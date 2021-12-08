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
        hour = "0"
        temp = "0"
        weatherImage = "not found"
    }
}
