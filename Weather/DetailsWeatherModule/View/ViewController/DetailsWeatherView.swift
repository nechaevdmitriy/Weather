//
//  DetailsWeatherView.swift
//  Weather
//
//  Created by Дмитрий  on 20.10.2021.
//

import UIKit

final class DetailsWeatherViewController: UIViewController, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView!
    let dataSource = DetailWeatherCollectionViewDataSource()
    weak var presenter: DetailsWeatherPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        collectionView = createCollectionView()
        view.backgroundColor = UIColor(named: "background")
    }
    
    private func setUpNavBar() {
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "Back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "Back")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "darkText")
        let back = UIBarButtonItem()
        back.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = back
    }
    
}

extension DetailsWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 400)
    }
}

extension DetailsWeatherViewController: DetailWeatherViewProtocol {
    
    func setWeatherData(data: WeatherOfTheFirstDayProtocol) {
        
    }
}
