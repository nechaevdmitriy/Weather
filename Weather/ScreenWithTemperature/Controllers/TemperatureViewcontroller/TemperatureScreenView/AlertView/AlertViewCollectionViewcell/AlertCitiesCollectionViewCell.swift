//
//  AlertCitiesCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 06.09.2021.
//

import UIKit

class AlertCitiesCollectionViewCell: UICollectionViewCell {

    static let id = "AlertCitiesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AlertCitiesCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var cityesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityesLabel.font = UIFont(name: "Manrope-Medium", size: 14)
        cityesLabel.textColor = UIColor(named: "gray")
    }

}
