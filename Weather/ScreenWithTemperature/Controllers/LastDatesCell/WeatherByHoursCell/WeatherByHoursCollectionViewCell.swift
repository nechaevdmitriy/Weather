//
//  WeatherByHoursCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 24.08.2021.
//

import UIKit

class WeatherByHoursCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let id = "WeatherByHoursCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherByHoursCollectionViewCell", bundle: nil)
    }
    
    func confugure(hourLabel: String, temperatureLabel: String, weatherImage: UIImage) {
        self.hourLabel.text = hourLabel
        self.temperatureLabel.text = temperatureLabel
        self.weatherImage.image = weatherImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
