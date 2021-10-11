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
    var errorAlert: ErrorAlertProtocol!
    
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
        let darkModeItem = DarkModeBarButtonItem(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        darkModeItem.addTarget(self, action: #selector(switchDarkMode), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: darkModeItem)
        
        guard let navController = navigationController else { return }
        self.title = title
        navController.navigationBar.barTintColor = .white
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.extraBold(size: 18)!]
        navController.navigationBar.shadowImage = UIImage()
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    private func showErrorAlert() {
        errorAlert.show()
        present(errorAlert, animated: true, completion: nil)
    }
    
    @objc private func switchDarkMode() {
        
    }
}
