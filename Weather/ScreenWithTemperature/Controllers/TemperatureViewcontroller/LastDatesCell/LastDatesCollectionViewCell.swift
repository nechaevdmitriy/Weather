//
//  LastDatesCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий  on 23.08.2021.
//

import UIKit

class LastDatesCollectionViewCell: UICollectionViewCell {
    
    var numberOfParentSection = Int()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var minimumTemperatureValue: UILabel!
    @IBOutlet weak var maximumTemperatureValue: UILabel!
    
    @IBOutlet weak var lastDatesCollectionView: UICollectionView!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var presenter: TemperaturePresenterProtocol!
    
    static let id = "LastDatesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "LastDatesCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let presenterData = TemperaturePresenter(view: self, networkService: NetworkWeatherManager.networkManager, requesType: .city(city: NetworkWeatherManager.networkManager.city))
        
        presenter = presenterData
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 16)
        currentDayLabel.font = UIFont(name: "Manrope-Medium", size: 16)
        minimumTemperatureValue.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        maximumTemperatureValue.font = UIFont(name: "Manrope-ExtraBold", size: 16)
        
        lastDatesCollectionView.register(WeatherByHoursCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherByHoursCollectionViewCell.id)
        
        lastDatesCollectionView.delegate = self
        lastDatesCollectionView.dataSource = self
        lastDatesCollectionView.showsHorizontalScrollIndicator = false
        lastDatesCollectionView.backgroundColor = UIColor(named: "backgroundCellGray")
        contentView.backgroundColor = UIColor(named: "backgroundCellGray")
    }
}

extension LastDatesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHoursCollectionViewCell.id, for: indexPath) as! WeatherByHoursCollectionViewCell
        cell.contentView.layer.cornerRadius = 8
        cell.backgroundColor = .none
        
        switch self.presenter.getDataByDayAndHour(indexOfDay: self.numberOfParentSection, indexOfHour: indexPath.row + 2)?.weather[0].weatherDescription {
        
        case "дождь", "пасмурно", "небольшой дождь":
            cell.weatherImage.image = #imageLiteral(resourceName: "Rain")
        case "гроза":
            cell.weatherImage.image = #imageLiteral(resourceName: "Thunder")
        default:
            cell.weatherImage.image = #imageLiteral(resourceName: "sun")
        }
        
        cell.temperatureLabel.text = Int(self.presenter.getDataByDayAndHour(indexOfDay: self.numberOfParentSection, indexOfHour: indexPath.row + 3)?.main.temp ?? 0).description + "℃"
        
        let hours = self.presenter.getDataByDayAndHour(indexOfDay: self.numberOfParentSection, indexOfHour: indexPath.row + 3)?.dtTxt.description.split(separator: " ").last?.description.split(separator: ":").first?.description
        
        cell.hourLabel.text = (hours ?? " ") + ":" + "00"
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: collectionView.bounds.height)
    }
}

extension LastDatesCollectionViewCell: TemperatureViewProtocol {
    func succes() {
        lastDatesCollectionView.reloadData()
    }
}