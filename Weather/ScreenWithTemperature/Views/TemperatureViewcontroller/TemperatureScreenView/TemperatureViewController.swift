//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit
import CoreLocation

protocol TemperatureViewProtocol: AnyObject {
    func succes()
}

class TemperatureViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var presenter: TemperaturePresenterProtocol!
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    let tapRecognizer = UITapGestureRecognizer()
    let bezier = UIBezierPath()
    
    override func viewDidLoad() {
        setupNavBar()
        tapRecognizer.addTarget(self, action: #selector(tap))
        view.addGestureRecognizer(tapRecognizer)
        DispatchQueue.main.async {
            super.viewDidLoad()
            self.setupLocationManager()
            self.setupView()
        }
    }
    
    private func setupNavBar() {
        title = "City"
        title = presenter.city
        
        let appiranceNavigationBar = UINavigationBarAppearance()
        appiranceNavigationBar.backgroundColor = UIColor(named: "backgroundApp")
        appiranceNavigationBar.shadowColor = .none
        
        navigationController?.navigationBar.standardAppearance = appiranceNavigationBar
        
        let searchAllertItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(presentCityesList))
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
        
        DispatchQueue.main.async {
            self.view.addSubview(temperaturecollectionview)
        }
        
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                temperaturecollectionview.topAnchor.constraint(equalTo: self.view.topAnchor),
                temperaturecollectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                temperaturecollectionview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                temperaturecollectionview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func presentCityesList() {
        let newVC = SavedCityesViewController()
        newVC.presenter = presenter
        navigationController?.pushViewController(newVC, animated: false)
    }
    
    @objc func getLocation() {
        presentLocation { String in
            LastDatesCollectionViewCell().presenter = self.presenter
        }
    }
    
    @objc func tap() {
        let newVC = DetailsWeatherViewController()
        newVC.presenter = presenter
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    func presentLocation(completionHandler: @escaping (String) -> Void) {
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forReqquesType: .coordinates(latitude: latitude, longitude: longitude)) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    
                    self.presenter.getLists(requesType: .coordinates(latitude: self.latitude, longitude: self.longitude))
                    self.presenter.currentWeather = data
                    self.title = self.presenter.city
                    self.viewDidLoad()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        viewDidLoad()
    }
    
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

extension TemperatureViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
