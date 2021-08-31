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
    
    static var indexOfParentSection = Int()
    
    static let id = "WeatherByHoursCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherByHoursCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(named: "darkBackgroundCellGray")
        contentView.layer.cornerRadius = 8
    }

}
