//
//  SavedCityesViewController.swift
//  Weather
//
//  Created by Дмитрий  on 09.09.2021.
//

import UIKit
import RealmSwift

protocol CityesAllertActionDelegate {
    func addCity(city: String)
}

class SavedCityesViewController: UIViewController {

    var list: [WeatherList]!
    let realm = try! Realm()
    var cityes: Results<Cityes>!
    var networkManager: NetworkWeatherServiceProtocol!
    
    var isOpenFlag = false
    
    @IBOutlet weak var cityesCollectionView: UICollectionView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var addCityButton: UIButton!
    @IBOutlet weak var getLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityesCollectionView.delegate = self
        cityesCollectionView.dataSource = self
        cityesCollectionView.register(CityesCollectionViewCell.nib(), forCellWithReuseIdentifier: CityesCollectionViewCell.id)
        setUpUI()
        cityesCollectionView.showsVerticalScrollIndicator = false
        cityes = realm.objects(Cityes.self)
    }
    
    @IBAction func addCityButtonPressed(_ sender: UIButton) {
        AlertView.instance.delegate = self
        
        AlertView.instance.parentView.isHidden = false
        
        view.addSubview(AlertView.instance.parentView)
    }
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        let newVC = MapViewController()
        navigationController?.pushViewController(newVC, animated: false)
    }
    
    private func setUpUI() {
        title = "Мои города"
        let switchThemeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "darkModeIcon"), style: .plain, target: self, action: #selector(switchDarkMode))
        switchThemeItem.tintColor = UIColor(named: "lightGray")
        
        self.navigationItem.setRightBarButton(switchThemeItem, animated: true)
        
        addCityButton.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 14)
    }
    
    @objc private func switchDarkMode() {
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

extension SavedCityesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityesCollectionViewCell.id, for: indexPath) as! CityesCollectionViewCell
        let item = cityes[indexPath.row]
        cell.cityLabel.text = item.city
        cell.layer.cornerRadius = 16
        
        networkManager.fetchCurrentWeather(forReqquesType: .city(city: item.city)) { CurrentWeather in
            switch CurrentWeather {
            
            case .success(let data):
                DispatchQueue.main.async {
                    cell.temperatureLabel.text = Int(data.list[0].main.temp).description
                    cell.feelsLikeLabel.text = Int(data.list[0].main.feelsLike).description
                    
                    switch data.list[0].weather[0].weatherDescription {
                    case "дождь", "небольшой дождь":
                        cell.weatherImage.image = #imageLiteral(resourceName: "Rain")
                    case "гроза":
                        cell.weatherImage.image = #imageLiteral(resourceName: "Thunder")
                    default:
                        cell.weatherImage.image = #imageLiteral(resourceName: "sun")
                    }
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
}

extension SavedCityesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Double(view.bounds.width) - 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 60, right: 0)
    }
}

extension SavedCityesViewController: CityesAllertActionDelegate {
    func addCity(city: String) {
        
        let selectedCity = Cityes()
        selectedCity.city = city
        
        try! realm.write({
            realm.add(selectedCity)
        })
        cityesCollectionView.reloadData()
    }
}
