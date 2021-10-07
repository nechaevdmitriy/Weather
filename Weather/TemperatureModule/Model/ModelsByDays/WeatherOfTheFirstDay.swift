//
//  ModeOfTheFirstDay.swift
//  Weather
//
//  Created by Дмитрий  on 01.10.2021.
//

import Foundation

protocol WeatherDataProtocol {
    var time: String { get }
    var weatherImage: String { get }
    var temperature: String { get }
}

protocol WeatherOfTheFirstDayProtocol: WeatherDataProtocol {
    var weatherDescription: String { get }
}

struct WeatherOfTheFirstDay: WeatherOfTheFirstDayProtocol {
    
    var time: String
    var weatherImage: String
    var temperature: String
    var weatherDescription: String
    
    init() {
        time = ""
        weatherImage = ""
        temperature = ""
        weatherDescription = ""
    }
    
    init(todayDate: String, weatherImage: String, currentTemp: String, weatherDescription: String) {
        self.time = todayDate
        self.weatherImage = weatherImage
        self.temperature = currentTemp
        self.weatherDescription = weatherDescription
    }
}
