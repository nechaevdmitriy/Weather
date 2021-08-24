//
//  CurrentWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

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
    
    func confugure(currentDayLabelText: String, currentTemperatureLabelText: String, weatherDescriptionText: String, weatherImage: UIImage) {
        
        self.currentDayLabel.text = currentDayLabelText
        self.currentDayLabel.text = currentTemperatureLabelText
        self.weatherDescription.text = weatherDescriptionText
        self.weatherImage.image = weatherImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
