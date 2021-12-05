//
//  DetailsWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import Foundation

protocol DetailWeatherViewProtocol: AnyObject {
}

protocol DetailsWeatherPresenterProtocol: AnyObject {
}

final class DetailsWeatherPresenter: DetailsWeatherPresenterProtocol {
    
    weak var view: DetailWeatherViewProtocol!
    private var weatherData: WeatherOfTheFirstDayProtocol!
    private var detailsWeatherModel = WeatherOfTheFirstDay()
    
    init(view: DetailWeatherViewProtocol, weatherData: WeatherOfTheFirstDayProtocol) {
        self.view = view
        self.weatherData = weatherData
    }
    
    func configureDetailsWeatherModel() -> WeatherOfTheFirstDayProtocol {
        detailsWeatherModel.time = weatherData.time
        detailsWeatherModel.weatherImage = weatherData.weatherImage
        detailsWeatherModel.temperature = weatherData.temperature
        detailsWeatherModel.weatherDescription = weatherData.weatherDescription
        detailsWeatherModel.humidity = weatherData.humidity
        detailsWeatherModel.windDescription = weatherData.windDescription
        detailsWeatherModel.rainfall = weatherData.rainfall
        return detailsWeatherModel
    }
}
