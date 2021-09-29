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
        let screenView = TemperatureScreenView()
        view.collectionViewScreen = screenView
        let networkService = NetworkWeatherManager.networkManager
        let presenter = TemperaturePresenter(view: view, networkLayer: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailsTemperatureModule() -> UIViewController {
        let view = DetailsWeatherViewController()
        let presenter = DetailsWeatherPresenter()
        view.presenter = presenter
        return view
    }
}
