//
//  DetailsWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import Foundation

protocol DetailWeatherViewProtocol: AnyObject {
    func setWeatherData(data: DetailsWeatherModelProtocol)
}

protocol DetailsWeatherPresenterProtocol: AnyObject {
    func showData()
}

final class DetailsWeatherPresenter: DetailsWeatherPresenterProtocol {
    
    weak var view: DetailWeatherViewProtocol!
    private var weatherData: DetailsWeatherModelProtocol!
    
    init(view: DetailWeatherViewProtocol, weatherData: DetailsWeatherModelProtocol) {
        self.view = view
        self.weatherData = weatherData
    }
    
    func showData() {
        view.setWeatherData(data: weatherData)
    }
}
