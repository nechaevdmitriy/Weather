//
//  Router.swift
//  Weather
//
//  Created by Дмитрий  on 11.10.2021.
//

import UIKit

protocol HeadRouterProtocol {
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: HeadRouterProtocol {
    func initialViewController()
    func popToRoot()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let mainViewController = assemblyBuilder.createTemperatureModule(router: self)
        navigationController.viewControllers = [mainViewController]
    }
    
    func popToRoot() {
        navigationController.popViewController(animated: true)
    }
    
}
