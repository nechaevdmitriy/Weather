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
    
    func showWeather() -> CurrentWeatherData? {
        var currentWeather = weather
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forReqquesType: .city(city: RequestParameters.city)) { result in
            switch result {
            case .success(let succes):
                currentWeather = succes
            case .failure(let error):
                print(error)
            }
            self.view.collectionView.reloadData()
        }
        return currentWeather
    }
    
    @objc func switchDarkMode() {
        view.switchDarkMode()
    }
}


