//
//  DetailsWeatherView.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

final class DetailsWeatherViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    weak var presenter: DetailsWeatherPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = createCollectionView()
    }
    
}

extension DetailsWeatherViewController: DetailWeatherViewProtocol {
    func setWeatherData(data: DetailsWeatherModelProtocol) {
        
    }
}
