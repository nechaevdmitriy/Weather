//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

protocol TemperatureViewProtocol: AnyObject {
    func succes()
}

class TemperatureViewController: UIViewController {
    
    var presenter: TemperaturePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
    
    private func setupNavBar() {
        title = "City"
        title = presenter.city
        
        let appiranceNavigationBar = UINavigationBarAppearance()
        appiranceNavigationBar.backgroundColor = UIColor(named: "backgroundApp")
        
        navigationController?.navigationBar.standardAppearance = appiranceNavigationBar
        navigationController?.navigationBar.scrollEdgeAppearance = appiranceNavigationBar
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchAllertItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(showAlert))
        searchAllertItem.tintColor = UIColor(named: "lightGray")
        
        let switchThemeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "darkModeIcon"), style: .plain, target: self, action: #selector(switchDarkMode))
        switchThemeItem.tintColor = UIColor(named: "lightGray")
        
        let getLocation = UIBarButtonItem(image: #imageLiteral(resourceName: "location"), style: .plain, target: self, action: #selector(getLocation))
        getLocation.tintColor = UIColor(named: "lightGray")
        
        self.navigationItem.setRightBarButtonItems([searchAllertItem, switchThemeItem], animated: false)
        self.navigationItem.setLeftBarButtonItems([getLocation], animated: false)
    }
    
    private func setupView() {
        let temperaturecollectionview = TemperatureScreenView()
        temperaturecollectionview.translatesAutoresizingMaskIntoConstraints = false
        temperaturecollectionview.presenter = presenter
        view.addSubview(temperaturecollectionview)
        
        NSLayoutConstraint.activate([
            temperaturecollectionview.topAnchor.constraint(equalTo: view.topAnchor),
            temperaturecollectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            temperaturecollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            temperaturecollectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func showAlert() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
        }
    }
    
    @objc func getLocation() {}
    
    @objc func switchDarkMode() {
        if #available(iOS 13, *) {
            
            let appDelegate = UIApplication.shared.windows.first
            
            if appDelegate?.overrideUserInterfaceStyle == .dark {
                appDelegate?.overrideUserInterfaceStyle = .light
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .dark
            return
        }
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    func succes() {
        self.viewDidLoad()
    }
}

