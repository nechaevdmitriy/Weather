//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class TemperatureViewController: UIViewController {
    
    let networkWeatherManager = NetworkWeatherManager.networkManager
    
    //MARK:- Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavBar()
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: "Moscow")
    }
    
    //MARK:- Private methods
    private func setupNavBar() {
        
        title = "Tambov"
        let appiranceNavigationBar = UINavigationBarAppearance()
        appiranceNavigationBar.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = appiranceNavigationBar
        navigationController?.navigationBar.scrollEdgeAppearance = appiranceNavigationBar
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        let searchAllertItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchCity))
        let switchThemeItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([searchAllertItem, switchThemeItem], animated: false)
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        view.addSubview(collectionView)
        
        collectionView.register(LastDatesCollectionViewCell.nib(), forCellWithReuseIdentifier: LastDatesCollectionViewCell.id)
        
        collectionView.register(CurrentWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func searchCity() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
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
            
            cell.confugure(currentDayLabelText: "meow", currentTemperatureLabelText: "Meow", weatherDescriptionText: "Meow", weatherImage: #imageLiteral(resourceName: "sun"))
            
            cell.layer.cornerRadius = 8
    
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastDatesCollectionViewCell.id, for: indexPath) as! LastDatesCollectionViewCell
            
            cell.confugure(dateLabel: "Day", currentDayLabel: "wtgrtw", minimumTemperatureValue: "rbtb", maximumTemperatureValue: "brtbrw")
            
            cell.layer.cornerRadius = 8

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
//                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}

