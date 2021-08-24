//
//  LastDatesCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class LastDatesCollectionViewCell: UICollectionViewCell {

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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastDatesCollectionView.register(WeatherByHoursCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherByHoursCollectionViewCell.id)
//        lastDatesCollectionView.delegate = self
//        lastDatesCollectionView.dataSource = self
    }

}
