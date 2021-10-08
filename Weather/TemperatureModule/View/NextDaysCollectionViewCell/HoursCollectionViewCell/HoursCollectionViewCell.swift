//
//  HoursCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

protocol HoursCollectionViewCellProtocol: UIView {
    func setUpData(model: WeatherByHours)
}

final class HoursCollectionViewCell: UICollectionViewCell {
    
    static let id = "HoursCollectionViewCell"
    var view: HoursCollectionViewCellProtocol!
    
    func setUpData(model: WeatherByHours) {
        view = HoursCollectionViewScreen(frame: self.bounds)
        view.setUpData(model: model)
        contentView.addSubview(view)
    }
}
