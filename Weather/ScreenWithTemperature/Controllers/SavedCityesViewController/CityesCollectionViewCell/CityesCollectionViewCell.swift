//
//  CityesCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 09.09.2021.
//

import UIKit

class CityesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    static let id = "CityesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CityesCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        cityLabel.font = UIFont(name: "Manrope-Medium", size: 16)
        temperatureLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        feelsLikeLabel.font = UIFont(name: "Manrope-ExtraBold", size: 16)
    }

}
