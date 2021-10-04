//
//  ModelsOfTheSecondDays.swift
//  Weather
//
//  Created by Дмитрий  on 01.10.2021.
//

import Foundation

struct ModelsOfTheSecondDays {
    var date: String
    var day: String
    var temp: String
    var feelsLike: String
    var weatherImage: String
    
    init() {
        date = ""
        day = ""
        temp = ""
        feelsLike = ""
        weatherImage = ""
    }
    
    init(date: String, day: String, temp: String, feelsLike: String, weatherImage: String) {
        self.date = date
        self.day = day
        self.temp = temp
        self.feelsLike = feelsLike
        self.weatherImage = weatherImage
    }
}
