//
//  Extension + DetailsWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

extension DetailWeatherCollectionViewCell {
    func createCurrentDayLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .semiBold(size: 14)
        return label
    }
    
    func createWeatherImage(image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        return imageView
    }
    
    func createTemperatureLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .extraBold(size: 48)
        return label
    }
    
    func createWeatherDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .semiBold(size: 14)
        return label
    }
    
    func createParameterLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .medium(size: 14)
        return label
    }
    
    func createBottomLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .extraBold(size: 32)
        return label
    }
    
    func createBackgroundImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailCellBackground")
        return imageView
    }
}
