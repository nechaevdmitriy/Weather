//
//  DetailsWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий  on 14.09.2021.
//

import Foundation

class DetailsWeatherPresenter {
    
    var countOfElementsInCurrentDay = 0
    var city = ""
    var view = DetailsWeatherViewController()
    var weather: CurrentWeatherData?
    var networkManager: NetworkWeatherServiceProtocol!
    
    func showWeather() -> CurrentWeatherData? {
        var currentWeather = weather
        networkManager.fetchCurrentWeather(forReqquesType: .city(city: RequestParameters.city)) { result in
            switch result {
            case .succes(value: let value):
                currentWeather = value
            case .failure(error: _):
                break
            }
            //self.view.collectionView.reloadData()
        }
        return currentWeather
    }
    
    @objc func switchDarkMode() {
        view.switchDarkMode()
    }
}


