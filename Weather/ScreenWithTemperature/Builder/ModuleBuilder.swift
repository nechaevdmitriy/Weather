//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Дмитрий  on 01.09.2021.
//

import UIKit

protocol Builder {
    static func createModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createModule() -> UIViewController {
        let view = TemperatureViewController()
        let networkService = NetworkWeatherManager.networkManager
        let presentor = TemperaturePresenter(view: view, networkService: networkService, requesType: .city(city: NetworkWeatherManager.networkManager.city))
        view.presenter = presentor
        return view
    }
}
