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

final class ModuleBuilder: Builder {
    
    static func createTemperatureModule() -> UIViewController {
        let view = TemperatureViewController()
        let screenView = TemperatureScreenView()
        view.collectionViewScreen = screenView
        let networkService = NetworkWeatherManager()
        let presenter = TemperaturePresenter(networkLayer: networkService)
        presenter.view = view
        view.presenter = presenter
        let errorNetworkAlert = ErrorNetworkAlert()
        let errorDarkModeAlert = DarkModeErrorAlert()
        view.errorNetworkAlert = errorNetworkAlert
        view.errorDarkModeAlert = errorDarkModeAlert
        return view
    }
    
    static func createDetailsTemperatureModule() -> UIViewController {
        let view = DetailsWeatherViewController()
        let presenter = DetailsWeatherPresenter()
        view.presenter = presenter
        return view
    }
}
