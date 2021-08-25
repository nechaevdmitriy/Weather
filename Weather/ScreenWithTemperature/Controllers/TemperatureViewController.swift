//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class TemperatureViewController: UIViewController {
    
    let networkWeatherManager = NetworkWeatherManager.networkManager
    let city = "Moscow"
    
    //MARK:- Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavBar()
    }
    
    //MARK:- Private methods
    private func setupNavBar() {
        
        title = "City"
        
        networkWeatherManager.fetchCurrentWeather(forCity: city, indexPath: 0) { current in
            DispatchQueue.main.async {
                self.title = current.cityName
            }
        }
        
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
        
        self.navigationItem.setRightBarButtonItems([searchAllertItem, switchThemeItem], animated: false)
        
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(named: "backgroundApp")
        
        view.addSubview(collectionView)
        
        collectionView.register(LastDatesCollectionViewCell.nib(), forCellWithReuseIdentifier: LastDatesCollectionViewCell.id)
        
        collectionView.register(CurrentWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func showAlert() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city, indexPath: 0) { currentWeather in
                print(currentWeather.cityName)
            }
        }
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


//MARK: - Extensions
extension TemperatureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.id, for: indexPath) as! CurrentWeatherCollectionViewCell
            
            cell.confugure(city: city, indexPath: indexPath.row)
            
            cell.layer.cornerRadius = 8
    
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastDatesCollectionViewCell.id, for: indexPath) as! LastDatesCollectionViewCell
            
            cell.layer.cornerRadius = 8
            NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: city, indexPath: indexPath.row) { current in
                
                DispatchQueue.main.async {
                    cell.minimumTemperatureValue.text = current.minimumTemperatureString
                    cell.maximumTemperatureValue.text = current.maximumTemperatureString
                    cell.currentDayLabel.text = current.currentDay
                }
            }

            return cell
        }
        
    }
}

extension TemperatureViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width - 32, height: 280)
            
        } else {
            return CGSize(width: view.frame.width - 32, height: 206)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}

extension TemperatureViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            tf.placeholder = "Tambov"
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName, indexPath: 0) { current in
                    DispatchQueue.main.async {
                        self.title = current.cityName
                        self.view.reloadInputViews()
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}

