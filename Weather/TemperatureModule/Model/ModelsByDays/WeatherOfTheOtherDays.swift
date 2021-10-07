//
//  ModelsOfTheSecondDays.swift
//  Weather
//
//  Created by Дмитрий  on 01.10.2021.
//

import Foundation

protocol WeatherOfTheOtherDaysProtocol: WeatherDataProtocol {
    var day: String { get }
    var feelsLike: String { get }
    var weatherByHours: [WeatherByHours] { get }
}

struct WeatherOfTheOtherDays: WeatherOfTheOtherDaysProtocol {
    
    var time: String
    var day: String
    var temperature: String
    var feelsLike: String
    var weatherImage: String
    var weatherByHours = [WeatherByHours]()
    
    init() {
        time = ""
        day = ""
        temperature = ""
        feelsLike = ""
        weatherImage = ""
    }
    
    init(date: String, day: String, temp: String, feelsLike: String, weatherImage: String) {
        self.time = date
        self.day = day
        self.temperature = temp
        self.feelsLike = feelsLike
        self.weatherImage = weatherImage
    }
}
