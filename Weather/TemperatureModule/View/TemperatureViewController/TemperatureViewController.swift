//
//  ViewController.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

protocol TemperatureViewPresenterProtocol: AnyObject {
    var weatherData: CurrentWeather? { get }
    var weatherOfTheDays: [[WeatherByDay]] { get set }
}

final class TemperatureViewController: UIViewController {

    var presenter: TemperatureViewPresenterProtocol!
    var collectionViewScreen: TemperatureScreenViewProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = collectionViewScreen
    }
    
    private func setUpNavBar() {
        title = presenter.weatherData?.city
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.extraBold(size: 18)!]
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Нет сети", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    func succes() {
        setUpNavBar()
        collectionViewScreen.collectionView?.reloadData()
    }
    
    func failure() {
        showErrorAlert()
        print("Данные не пришли")
    }
}
