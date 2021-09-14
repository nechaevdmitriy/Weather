//
//  TemperatureScreenView.swift
//  Weather
//
//  Created by Дмитрий  on 03.09.2021.
//

import UIKit

class TemperatureScreenView: UIView {
    
    var presenter: TemperaturePresenterProtocol!
    
    init() {
        super.init(frame: .zero)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(named: "backgroundApp")
        
        collectionView.register(LastDatesCollectionViewCell.nib(), forCellWithReuseIdentifier: LastDatesCollectionViewCell.id)
        
        collectionView.register(CurrentWeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TemperatureScreenView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.id, for: indexPath) as! CurrentWeatherCollectionViewCell
            
            switch presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: 0)?.weather[0].weatherDescription {
            
            case "дождь", "пасмурно", "небольшой дождь":
                cell.weatherImage.image = #imageLiteral(resourceName: "Rain")
            case "гроза":
                cell.weatherImage.image = #imageLiteral(resourceName: "Thunder")
            default:
                cell.weatherImage.image = #imageLiteral(resourceName: "sun")
            }
            
            cell.weatherDescription.text = presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: 0)?.weather[0].weatherDescription
            
            cell.currentTemperatureLabel.text = Int(presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: 0)?.main.temp ?? 0).description + "℃"
            
            let day = self.presenter.getDataByDayAndHour(indexOfDay: 0, indexOfHour: 0)?.dtTxt.split(separator: " ").first?.description.capitalized
            
            let convertedValue = HelperDate.changeDateFormat(dateString: day ?? "", fromFormat: "yyyy-MM-dd", toFormat: "d MMMM, EEE")
            
            cell.currentDayLabel.text = "Сегодня," + " " + convertedValue
            cell.layer.cornerRadius = 16
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastDatesCollectionViewCell.id, for: indexPath) as! LastDatesCollectionViewCell
            
            cell.numberOfParentSection = indexPath.row
            cell.presenter = self.presenter
            cell.layer.cornerRadius = 16
            
            var weatherdescriptions = [String]()
            var temperatureValue = [Int]()
            
            for i in 3...7 {
                weatherdescriptions.append(self.presenter.getDataByDayAndHour(indexOfDay: indexPath.row, indexOfHour: i)?.weather[0].weatherDescription ?? " ")
                
                temperatureValue.append(Int(self.presenter.getDataByDayAndHour(indexOfDay: indexPath.row, indexOfHour: i)?.main.temp ?? 0))
            }
            
            let oftenValueWeather = weatherdescriptions.reduce(String()) { $0 == $1 ? $0 : $1}
            
            let maxValue = temperatureValue.max()
            let minValue = temperatureValue.min()
            
            cell.maximumTemperatureValue.text = "\(maxValue ?? 0)"
            cell.minimumTemperatureValue.text = "\(minValue ?? 0)"
            
            switch oftenValueWeather {
            
            case "дождь", "небольшой дождь":
                cell.weatherImage.image = #imageLiteral(resourceName: "Rain")
            case "гроза":
                cell.weatherImage.image = #imageLiteral(resourceName: "Thunder")
            default:
                cell.weatherImage.image = #imageLiteral(resourceName: "sun")
            }
            
            let date = self.presenter.getDataByDayAndHour(indexOfDay: indexPath.row, indexOfHour: 0)?.dtTxt.split(separator: " ").first?.description
            
            let convertDatefromDay = HelperDate.changeDateFormat(dateString: date ?? "", fromFormat: "yyyy-MM-dd", toFormat: "EEE")
            
            let convertDatefromMonth = HelperDate.changeDateFormat(dateString: date ?? "", fromFormat: "yyyy-MM-dd", toFormat: "d MMMM")
            
            DispatchQueue.main.async {
                cell.currentDayLabel.text = convertDatefromDay
                cell.dateLabel.text = convertDatefromMonth
            }
            cell.lastDatesCollectionView.reloadData()
            return cell
        }
    }
}

extension TemperatureScreenView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: self.frame.width - 32, height: 280)
            
        } else {
            return CGSize(width: self.frame.width - 32, height: 206)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}

extension TemperatureScreenView: TemperatureViewProtocol {
    func succes() {
        self.reloadInputViews()
    }
}

