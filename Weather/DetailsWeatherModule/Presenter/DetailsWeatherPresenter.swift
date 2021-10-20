//
//  DetailsWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import Foundation

protocol DetailWeatherViewProtocol: AnyObject {
    func setWeatherData(data: WeatherDataProtocol)
}

protocol DetailsWeatherPresenterProtocol: AnyObject {
    func showData()
}

final class DetailsWeatherPresenter: DetailsWeatherPresenterProtocol {
    
    weak var view: DetailWeatherViewProtocol!
    private var weatherData: WeatherDataProtocol!
    
    init(view: DetailWeatherViewProtocol, weatherData: WeatherDataProtocol) {
        self.view = view
        self.weatherData = weatherData
    }
    
    func showData() {
    }
    
}
