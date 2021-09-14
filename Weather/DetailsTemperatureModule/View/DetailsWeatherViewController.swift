//
//  DetailsWeatherViewController.swift
//  Weather
//
//  Created by Дмитрий  on 06.09.2021.
//

import UIKit

class DetailsWeatherViewController: UIViewController {
    
    //MARK: - Properties
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    var presenter: DetailsWeatherViewPresenter!
    var list: WeatherList?
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(named: "backgroundApp")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: DetailsWeatherCollectionViewCell.id)
        collectionView.register(ChartCollectionViewCell.nib(), forCellWithReuseIdentifier: ChartCollectionViewCell.id)
        setUpConstraints()
        setUpNavBar()
    }
    
    //MARK: - Private funcs
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
    
    @objc func presentCityesList() {
        let newVC = SavedCityesViewController()
        navigationController?.pushViewController(newVC, animated: false)
    }
    
    private func setUpNavBar() {
        let searchAllertItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(presentCityesList))
        searchAllertItem.tintColor = UIColor(named: "lightGray")
        title = presenter.city
        
        let switchThemeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "darkModeIcon"), style: .plain, target: self, action: #selector(switchDarkMode))
        switchThemeItem.tintColor = UIColor(named: "lightGray")
        
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "Vector")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Vector")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationItem.setRightBarButtonItems([searchAllertItem, switchThemeItem], animated: false)
    }
    
    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(named: "backgroundApp")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

//MARK: - Extensions
extension DetailsWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsWeatherCollectionViewCell.id, for: indexPath) as! DetailsWeatherCollectionViewCell
            cell.layer.cornerRadius = 16
            cell.backgroundColor = .none
            
            switch presenter.showWeather()?.list[0].weather[0].weatherDescription {
            
            case "дождь", "пасмурно", "небольшой дождь":
                cell.weatherImage.image = #imageLiteral(resourceName: "Rain")
            case "гроза":
                cell.weatherImage.image = #imageLiteral(resourceName: "Thunder")
            default:
                cell.weatherImage.image = #imageLiteral(resourceName: "sun")
            }
            
            cell.currentTemperatureLabel.text = Int(list?.main.temp ?? 0).description + "℃"
            
            let day = presenter.showWeather()?.list[0].dtTxt.split(separator: " ").first?.description.capitalized
            
            let convertedValue = HelperDate.changeDateFormat(dateString: day ?? "", fromFormat: "yyyy-MM-dd", toFormat: "d MMMM, EEE")
            
            cell.currentDayLabel.text = "Сегодня," + " " + convertedValue
            cell.windDescription.text = Int(presenter.showWeather()?.list[0].wind.speed ?? 0).description
            
            cell.humidityDescription.text = Int(presenter.showWeather()?.list[0].main.humidity ?? 0).description
            
            cell.precipitationDescription.text = Int(presenter.showWeather()?.list[0].pop ?? 0).description
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.id, for: indexPath) as! ChartCollectionViewCell
            cell.layer.cornerRadius = 16
            cell.presenter = presenter
            return cell
        }
    }
}

//MARK: - Extensions
extension DetailsWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.bounds.width - 32, height: 390)
        } else {
            return CGSize(width: view.bounds.width - 48, height: view.bounds.height / 3 )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
}

extension DetailsWeatherViewController: DetailsWeatherViewProtocol {
    func getWeather(list: WeatherList) {
        self.list = list
    }
}
