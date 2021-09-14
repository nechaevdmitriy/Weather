//
//  DetailsWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий  on 14.09.2021.
//

import Foundation

protocol DetailsWeatherViewProtocol {
    func getWeather(list: WeatherList)
}

protocol DetailsWeatherViewPresenter {
    var countOfElementsInCurrentDay: Int { get set }
    var city: String? { get set }
    init(view: DetailsWeatherViewProtocol, weather: CurrentWeatherData?)
    func showWeather () -> CurrentWeatherData?
}

class DetailsWeatherPresenter: DetailsWeatherViewPresenter {
    var countOfElementsInCurrentDay: Int
    var city: String?
    let view: DetailsWeatherViewProtocol
    let weather: CurrentWeatherData?
    
    required init(view: DetailsWeatherViewProtocol, weather: CurrentWeatherData?) {
        self.view = view
        self.weather = weather
        self.city = weather?.city.name
        self.countOfElementsInCurrentDay = weather?.list.count ?? 0
    }
    
    func showWeather() -> CurrentWeatherData? {
        let currentWeather = weather
        return currentWeather
    }
    
    
}


