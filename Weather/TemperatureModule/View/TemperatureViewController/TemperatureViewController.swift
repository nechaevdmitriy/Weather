//
//  ViewController.swift
//  Weather-2.0
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

protocol TemperatureViewPresenterProtocol: AnyObject {
    func showWeatherList()
    func tapOnTheCell(model: WeatherDataProtocol)
}

protocol TemperatureScreenViewProtocol: UIView {
    func setupDataSource(days: [WeatherDataProtocol])
}

protocol ErrorAlertProtocol: UIAlertController {}

final class TemperatureViewController: UIViewController {
    
    var presenter: TemperatureViewPresenterProtocol!
    var collectionViewScreen: TemperatureScreenViewProtocol!
    var errorNetworkAlert: ErrorAlertProtocol!
    var errorDarkModeAlert: ErrorAlertProtocol!
    var bottomImageBlur: UIImageView!
    
    override func loadView() {
        super.loadView()
        presenter.showWeatherList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = collectionViewScreen
        bottomImageBlur = createBottomImage()
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    func succes(days: [WeatherDataProtocol], title: String) {
        collectionViewScreen.setupDataSource(days: days)
        setUpNavBar(title: title)
    }
    
    func failure() {
        present(errorNetworkAlert, animated: true, completion: nil)
    }
    
    private func setUpNavBar(title: String) {
        assert(navigationController != nil, "Empty navigationController")
        let darkModeItemButton = DarkModeBarButtonItemButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        darkModeItemButton.addTarget(self, action: #selector(switchDarkMode), for: .touchUpInside)
        let switchThemeItem = UIBarButtonItem(customView: darkModeItemButton)
        self.navigationItem.rightBarButtonItem = switchThemeItem
        self.title = title
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
            present(errorDarkModeAlert, animated: true, completion: nil)
        }
    }
}
