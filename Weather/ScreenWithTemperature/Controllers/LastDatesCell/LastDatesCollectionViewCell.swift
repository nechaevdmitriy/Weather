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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastDatesCollectionView.register(WeatherByHoursCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherByHoursCollectionViewCell.id)
        
        lastDatesCollectionView.delegate = self
        lastDatesCollectionView.dataSource = self
        lastDatesCollectionView.showsHorizontalScrollIndicator = false
        lastDatesCollectionView.backgroundColor = UIColor(named: "backgroundCellGray")
        contentView.backgroundColor = UIColor(named: "backgroundCellGray")
        
    }
}

extension LastDatesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHoursCollectionViewCell.id, for: indexPath) as! WeatherByHoursCollectionViewCell
        cell.contentView.layer.cornerRadius = 8
        cell.backgroundColor = .none
        
        NetworkWeatherManager.networkManager.fetchCurrentWeather(forCity: "Moscow", indexPath: indexPath.row) { current in
            
            DispatchQueue.main.async {
//                cell.temperatureLabel.text = current.getDatabyDayAndHour(indexOfDay: 0, indexOfHour: 0)?.dtTxt
                cell.hourLabel.text = self.dates[indexPath.row]
                cell.layer.cornerRadius = 8
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: collectionView.bounds.height)
        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
//    }
    
    
}
