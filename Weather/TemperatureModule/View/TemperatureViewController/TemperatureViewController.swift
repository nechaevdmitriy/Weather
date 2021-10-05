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

final class TemperatureViewController: UIViewController {
    
    var presenter: TemperatureViewPresenterProtocol!
    var collectionViewScreen: TemperatureScreenViewProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showWeatherList()
        view = collectionViewScreen
    }
    
    private func setUpNavBar(title: String) {
        assert(navigationController != nil, "Empty navigationController")
        guard let navController = navigationController else { return }
        self.title = title
        navController.navigationBar.barTintColor = .white
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.extraBold(size: 18)!]
        navController.navigationBar.shadowImage = UIImage()
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Нет сети", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    func succes(firstDay: WeatherOfTheFirstDay, secondDays: [WeatherOfTheOtherDays]) {
        collectionViewScreen.setupDataSource(firstDay: firstDay, secondDays: secondDays)
        collectionViewScreen.reloadData()
    }
    
    func setTitle(title: String) {
        setUpNavBar(title: title)
    }
    
    func failure() {
        showErrorAlert()
        print("Данные не пришли")
    }
}
