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
        label.textAlignment = .center
        label.font = .semiBold(size: 14)
        label.textColor = .white
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
        label.textAlignment = .center
        label.font = .extraBold(size: 48)
        label.textColor = .white
        return label
    }
    
    func createWeatherDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .semiBold(size: 14)
        label.textColor = .white
        return label
    }
    
    func createParameterLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .medium(size: 14)
        label.textColor = .white
        return label
    }
    
    func createBottomLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .extraBold(size: 32)
        label.textColor = .white
        return label
    }
    
    func createBackgroundImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailCellBackground")
        imageView.contentMode = .scaleToFill
        return imageView
    }
}
