//
//  NextDayCollectionViewCell.swift
//  Weather-2.1
//
//  Created by Дмитрий  on 23.09.2021.
//

import UIKit

protocol NextDayViewProtocol: UIView {
    func configure()
    func setUpData(model: WeatherOfTheOtherDays)
}

final class NextDayCollectionViewCell: UICollectionViewCell {
    
    static let id = "NextDayCollectionViewCell"
    var view: NextDayViewProtocol!
    
    func configure(model: WeatherOfTheOtherDays) {
        view = NextDayCollectionViewScreen(frame: self.bounds)
        view.configure()
        view.setUpData(model: model)
        contentView.addSubview(view)
    }
}
