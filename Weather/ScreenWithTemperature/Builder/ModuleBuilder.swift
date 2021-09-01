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
        let presentor = temperaturePresentor(view: view, networkService: networkService)
        view.presentor = presentor
        return view
    }
}
