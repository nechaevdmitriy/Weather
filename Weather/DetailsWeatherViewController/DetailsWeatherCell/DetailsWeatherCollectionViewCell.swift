//
//  DetailsWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 06.09.2021.
//

import UIKit

class DetailsWeatherCollectionViewCell: UICollectionViewCell {
    
    static let id = "DetailsWeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailsWeatherCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windDescription: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityDescription: UILabel!
    
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var precipitationDescription: UILabel!
    
    @IBOutlet weak var methresLabel: UILabel!
    @IBOutlet weak var procentHumidity: UILabel!
    @IBOutlet weak var procentPrecipitationLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        methresLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        procentHumidity.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        procentPrecipitationLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        
        currentDayLabel.font = UIFont(name: "Manrope-SemiBold", size: 14)
        currentTemperatureLabel.font = UIFont(name: "Manrope-ExtraBold", size: 48)
        
        windLabel.font = UIFont(name: "Manrope-Medium", size: 14)
        windDescription.font = UIFont(name: "Manrope-ExtraBold", size: 32)
        
        humidityLabel.font = UIFont(name: "Manrope-Medium", size: 14)
        humidityDescription.font = UIFont(name: "Manrope-ExtraBold", size: 32)
        
        precipitationLabel.font = UIFont(name: "Manrope-Medium", size: 14)
        precipitationDescription.font = UIFont(name: "Manrope-ExtraBold", size: 32)
    }
}
