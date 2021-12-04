//
//  DetailsWeatherDescriptionModel.swift
//  Weather
//
//  Created by Дмитрий  on 04.12.2021.
//

import Foundation

protocol DetailsWeatherModelProtocol: WeatherDataProtocol {
    var time: String { get }
    var weatherImage: String { get }
    var temperature: String { get }
    var weatherDescription: String { get }
    var windDescription: String { get }
    var humidity: String { get }
    var rainfall: String { get }
}

struct DetailsWeatherModel: DetailsWeatherModelProtocol {
    var time: String
    var weatherImage: String
    var temperature: String
    var weatherDescription: String
    var windDescription: String
    var humidity: String
    var rainfall: String
}
