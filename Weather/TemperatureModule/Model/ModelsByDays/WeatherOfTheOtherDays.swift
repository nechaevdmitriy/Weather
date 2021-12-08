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
        time = "00:00"
        day = "not found"
        temperature = "0"
        feelsLike = "0"
        weatherImage = "0"
    }
}
