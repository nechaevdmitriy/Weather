//
//  ViewController.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

protocol TemperatureViewPresenterProtocol: AnyObject {
    func showWeatherList()
}

protocol TemperatureScreenViewProtocol: UIView {
    func setupDataSource(days: [WeatherDataProtocol])
}

protocol ErrorAlertProtocol: UIAlertController {
    func show()
}

final class TemperatureViewController: UIViewController {
    
    var presenter: TemperatureViewPresenterProtocol!
    var collectionViewScreen: TemperatureScreenViewProtocol!
    var errorNetworkAlert: ErrorAlertProtocol!
    var errorDarkModeAlert: ErrorAlertProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showWeatherList()
        view = collectionViewScreen
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    func succes(days: [WeatherDataProtocol], title: String) {
        collectionViewScreen.setupDataSource(days: days)
        setUpNavBar(title: title)
    }
    
    func failure() {
        showErrorAlert()
        print("Данные не пришли")
    }
    
    private func setUpNavBar(title: String) {
        assert(navigationController != nil, "Empty navigationController")
        self.title = title
        
        let darkModeItemButton = DarkModeBarButtonItemButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        darkModeItemButton.addTarget(self, action: #selector(switchDarkMode), for: .touchUpInside)
        let switchThemeItem = UIBarButtonItem(customView: darkModeItemButton)
        self.navigationItem.rightBarButtonItem = switchThemeItem
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.extraBold(size: 18)!]
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func showErrorAlert() {
        errorNetworkAlert.show()
        present(errorNetworkAlert, animated: true, completion: nil)
    }
    
    @objc private func switchDarkMode() {
        if #available(iOS 13, *) {
            let appDelegate = UIApplication.shared.windows.first
            if appDelegate?.overrideUserInterfaceStyle == .dark {
                appDelegate?.overrideUserInterfaceStyle = .light
            } else {
                appDelegate?.overrideUserInterfaceStyle = .dark
            }
        } else {
            errorDarkModeAlert.show()
            present(errorDarkModeAlert, animated: true, completion: nil)
        }
    }
}
