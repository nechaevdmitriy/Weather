//
//  NextDayCollectionViewScreen.swift
//  Weather
//
//  Created by Дмитрий  on 07.10.2021.
//

import UIKit

class NextDayCollectionViewScreen: UIView, UICollectionViewDelegate, NextDayViewProtocol {
    
    let layout = UICollectionViewFlowLayout()
    let dateLabel = UILabel()
    let dayLabel = UILabel()
    let temperatureLabel = UILabel()
    let feelsLikeLabel = UILabel()
    let lineView = UIView()
    let weatherImage = UIImageView()
    var collectionView: UICollectionView!
    let dataSource = NextDaysCollectionViewDataSource()
    
    func configure() {
        configureCollectionView()
        self.layer.cornerRadius = 16
        cunfigureLabels()
        configureImages()
        setUpConstraints()
    }
    
    func setUpData(model: WeatherOfTheOtherDays) {
        dateLabel.text = model.time
        dayLabel.text = model.day
        weatherImage.image = UIImage(named: model.weatherImage) ?? #imageLiteral(resourceName: "01d")
        temperatureLabel.text = model.temperature
        feelsLikeLabel.text = model.feelsLike
        dataSource.weatherByHours = model.weatherByHours
        collectionView.reloadData()
    }
    
    private func setUpConstraints() {
        offAutoresizingMasks(elements: [dateLabel, dayLabel, temperatureLabel, feelsLikeLabel, weatherImage, lineView])
        
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            dayLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 4),
            
            weatherImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            weatherImage.heightAnchor.constraint(equalToConstant: 24),
            weatherImage.widthAnchor.constraint(equalToConstant: 24),
            
            lineView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -8),
            
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            temperatureLabel.trailingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor, constant: -8)
        ])
    }
    
    private func cunfigureLabels() {
        dateLabel.font = UIFont.medium(size: 16)
        dateLabel.textColor = UIColor(named: "darkText")
        dateLabel.text = "date"
        self.addSubview(dateLabel)
        
        dayLabel.font = UIFont.medium(size: 16)
        dayLabel.textColor = UIColor(named: "grayText")
        dayLabel.text = "day"
        self.addSubview(dayLabel)
        
        temperatureLabel.font = UIFont.extraBold(size: 16)
        temperatureLabel.textColor = UIColor(named: "darkText")
        temperatureLabel.text = "temp"
        self.addSubview(temperatureLabel)
        
        feelsLikeLabel.font = UIFont.extraBold(size: 16)
        feelsLikeLabel.textColor = UIColor(named: "grayText")
        feelsLikeLabel.text = "fl"
        self.addSubview(feelsLikeLabel)
    }
    
    private func configureCollectionView() {
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(HoursCollectionViewCell.self, forCellWithReuseIdentifier: HoursCollectionViewCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        self.backgroundColor = UIColor(named: "firstCell")
        collectionView.backgroundColor = UIColor(named: "firstCell")
        collectionView.layer.cornerRadius = 16
        self.addSubview(collectionView)
    }
    
    private func configureImages() {
        weatherImage.image = #imageLiteral(resourceName: "01d")
        self.addSubview(weatherImage)
        lineView.backgroundColor = UIColor(named: "secondCell")
        self.addSubview(lineView)
    }
}

extension NextDayCollectionViewScreen: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 72, left: 20, bottom: 16, right: 20)
    }
}
