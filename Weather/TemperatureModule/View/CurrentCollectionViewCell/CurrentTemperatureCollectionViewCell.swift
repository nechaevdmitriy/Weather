//
//  CurrentTemperatureCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 22.09.2021.
//

import UIKit

protocol CurrentTemperatureCellScreenProtocol: UIView {
    func configure(model: WeatherOfTheFirstDay)
}

final class CurrentTemperatureCollectionViewCell: UICollectionViewCell {
    
    static let id = "CurrentTemperatureCollectionViewCell"
    var view: CurrentTemperatureCellScreenProtocol!
    
    func configure(firstDay: WeatherOfTheFirstDay) {
        view = CurrentTemperatureCellScreen(frame: contentView.bounds)
        view.configure(model: firstDay)
        contentView.addSubview(view)
    }
}
