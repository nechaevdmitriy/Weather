//
//  DetailsWeatherDescriptionModel.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import Foundation

struct DetailsWeatherModel: WeatherDataProtocol {
    var time: String
    var weatherImage: String
    var temperature: String
    var weatherDescription: String
    var windDescription: String
    var humidity: String
    var rainfall: String
}
