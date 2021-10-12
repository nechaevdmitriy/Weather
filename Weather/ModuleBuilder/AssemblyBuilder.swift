//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Дмитрий  on 01.09.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createTemperatureModule(router: RouterProtocol) -> UIViewController
    func createDetailsTemperatureModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createDetailsTemperatureModule(router: RouterProtocol) -> UIViewController {
        let view = DetailsWeatherViewController()
        let presenter = DetailsWeatherPresenter()
        view.presenter = presenter
        return view
    }
    
    func createTemperatureModule(router: RouterProtocol) -> UIViewController {
        let view = TemperatureViewController()
        let screenView = TemperatureScreenView()
        view.collectionViewScreen = screenView
        let networkService = NetworkWeatherManager()
        let presenter = TemperaturePresenter(networkLayer: networkService, router: router)
        presenter.view = view
        view.presenter = presenter
        let errorNetworkAlert = ErrorNetworkAlert()
        let errorDarkModeAlert = DarkModeErrorAlert()
        view.errorNetworkAlert = errorNetworkAlert
        view.errorDarkModeAlert = errorDarkModeAlert
        return view
    }
    
}
