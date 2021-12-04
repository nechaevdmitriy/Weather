//
//  DetailWeatherCollectionViewDataSource.swift
//  Weather
//
//  Created by Дмитрий  on 04.12.2021.
//

import UIKit

final class DetailWeatherCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var model: WeatherOfTheFirstDayProtocol!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherCollectionViewCell().id, for: indexPath) as! DetailWeatherCollectionViewCell
        cell.configure(weatherData: model)
        return cell
    }
}
