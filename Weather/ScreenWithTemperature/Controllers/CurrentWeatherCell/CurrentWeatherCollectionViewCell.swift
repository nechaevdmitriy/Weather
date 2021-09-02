//
//  CurrentWeatherCollectionViewCell.swift
//  Weather
//  Created by Дмитрий  on 23.08.2021.

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {

    static let collectionCell = CurrentWeatherCollectionViewCell()
    
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    static let id = "CurrentWeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrentWeatherCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reloadInputViews()
        currentDayLabel.font = UIFont(name: "Manrope-SemiBold", size: 14)
        currentTemperatureLabel.font = UIFont(name: "Manrope-ExtraBold", size: 48)
        weatherDescription.font = UIFont(name: "Manrope-SemiBold", size: 14)
    }
}
