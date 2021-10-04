//
//  CurrentTemperatureCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

protocol CurrentTemperatureCellScreenProtocol: UIView {
    func configure(model: ModelOfTheFirstDay)
}

final class CurrentTemperatureCollectionViewCell: UICollectionViewCell {
    
    var infoAboutFirstDay = ModelOfTheFirstDay()
    
    static let id = "CurrentTemperatureCollectionViewCell"
    var view: CurrentTemperatureCellScreenProtocol!
    
    func configure() {
        view.configure(model: infoAboutFirstDay)
        contentView.addSubview(view)
    }
}
