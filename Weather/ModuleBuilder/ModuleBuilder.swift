//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Дмитрий  on 01.09.2021.
//

import UIKit

protocol Builder {
    static func createTemperatureModule() -> UIViewController
    static func createDetailsTemperatureModule() -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createTemperatureModule() -> UIViewController {
        let view = TemperatureViewController()
        let networkService = NetworkWeatherManager.networkManager
        let presentor = TemperaturePresenter(view: view, networkService: networkService, requesType: .city(city: NetworkWeatherManager.networkManager.city))
        view.presenter = presentor
        return view
    }
    
    static func createDetailsTemperatureModule() -> UIViewController {
        
        var weather: CurrentWeatherData?
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forReqquesType: .city(city: NetworkWeatherManager.networkManager.city)) { result in
            
            switch result {
            case .success(let succes):
                weather = succes
            case .failure(let error):
                print(error)
            }
        }
        
        let view = DetailsWeatherViewController()
            let presenter = DetailsWeatherPresenter(view: view, weather: weather)
            view.presenter = presenter
        return view
    }
}
