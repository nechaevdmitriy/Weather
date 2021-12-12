//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Дмитрий  on 01.09.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createTemperatureModule(router: RouterProtocol) -> UIViewController
    func createDetailsWeatherModule(router: RouterProtocol, weatherData: WeatherOfTheFirstDayProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createTemperatureModule(router: RouterProtocol) -> UIViewController {
        let view = TemperatureViewController()
        let errorNetworkAlert = ErrorNetworkAlert()
        let errorDarkModeAlert = DarkModeErrorAlert()
        view.errorNetworkAlert = errorNetworkAlert
        view.errorDarkModeAlert = errorDarkModeAlert
        let screenView = TemperatureScreenView()
        screenView.parent = view
        view.collectionViewScreen = screenView
        let networkService = NetworkWeatherManager()
        let weatherstorageManager = WeatherStorageManager()
        networkService.storageDelegate = weatherstorageManager
        let presenter = TemperaturePresenter(networkLayer: networkService, router: router)
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func createDetailsWeatherModule(router: RouterProtocol, weatherData: WeatherOfTheFirstDayProtocol) -> UIViewController {
        let view = DetailsWeatherViewController()
        let presenter = DetailsWeatherPresenter(view: view, weatherData: weatherData)
        view.presenter = presenter
        presenter.view = view
        view.dataSource.model = presenter.configureDetailsWeatherModel()
        return view
    }
}
