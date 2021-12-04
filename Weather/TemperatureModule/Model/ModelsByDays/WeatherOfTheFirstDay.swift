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
    var humidity: String { get }
    var rainfall: String { get }
    var windDescription: String { get }
}

struct WeatherOfTheFirstDay: WeatherOfTheFirstDayProtocol {
    
    var time: String
    var weatherImage: String
    var temperature: String
    var weatherDescription: String
    var humidity: String
    var rainfall: String
    var windDescription: String
    
    init() {
        time = ""
        weatherImage = ""
        temperature = ""
        weatherDescription = ""
        humidity = ""
        rainfall = ""
        windDescription = ""
    }
}
