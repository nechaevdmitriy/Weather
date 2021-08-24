//
//  LastDatesCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class LastDatesCollectionViewCell: UICollectionViewCell {
    
    let dates = ["12:00", "15:00", "18:00", "21:00", "00:00"]

    static let collectionCell = LastDatesCollectionViewCell()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var minimumTemperatureValue: UILabel!
    @IBOutlet weak var maximumTemperatureValue: UILabel!
    
    @IBOutlet weak var lastDatesCollectionView: UICollectionView!
    
    static let id = "LastDatesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "LastDatesCollectionViewCell", bundle: nil)
    }
    
    func confugure(dateLabel: String, currentDayLabel: String, minimumTemperatureValue: String, maximumTemperatureValue: String) {
        self.dateLabel.text = dateLabel
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: "Moscow", index: 0, complitionHandler: { [unowned self] CurrentWeather in
            DispatchQueue.main.async {
                self.minimumTemperatureValue.text = CurrentWeather.minimumTemperatureString
                self.maximumTemperatureValue.text = CurrentWeather.maximumTemperatureString
            }
        })
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastDatesCollectionView.register(WeatherByHoursCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherByHoursCollectionViewCell.id)
        lastDatesCollectionView.delegate = self
        lastDatesCollectionView.dataSource = self
        lastDatesCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension LastDatesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHoursCollectionViewCell.id, for: indexPath) as! WeatherByHoursCollectionViewCell
        cell.confugure(hourLabel: dates[indexPath.row], temperatureLabel: "0")
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: "Moscow", index: indexPath.row, complitionHandler: { currentWeather in
            DispatchQueue.main.async {
                cell.temperatureLabel.text = currentWeather.temperatureString
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: contentView.bounds.height)
        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
//    }
    
    
}
