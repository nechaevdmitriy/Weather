//
//  DetailsWeatherView.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

final class DetailsWeatherViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = createCollectionView()
    }
    
}

extension DetailsWeatherViewController: DetailWeatherViewProtocol {
    func setWeatherData(data: WeatherDataProtocol) {
        
    }
}
