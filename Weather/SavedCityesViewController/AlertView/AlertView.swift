//
//  AlertView.swift
//  Weather
//
//  Created by Дмитрий  on 03.09.2021.
//

import UIKit
import RealmSwift

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cityesTextField: UITextField!
    @IBOutlet weak var cityesCollectionView: UICollectionView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let recomendedCityes = ["Тамбов", "Омск", "Саратов", "Петрозаводск", "Краков"]
    var delegate: CityesAllertActionDelegate!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        configureUI()
        cityesCollectionView.delegate = self
        cityesCollectionView.dataSource = self
        cityesCollectionView.register(AlertCitiesCollectionViewCell.nib(), forCellWithReuseIdentifier: AlertCitiesCollectionViewCell.id)
        
        cityesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        parentView.isHidden = true
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
            delegate.addCity(city: cityesTextField.text ?? "")
            parentView.isHidden = true
    }
    
    private func configureUI() {
        backgroundView.layer.cornerRadius = 8
        acceptButton.layer.cornerRadius = 4
        cancelButton.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 14)
        acceptButton.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 14)
        cancelButton.layer.cornerRadius = 4
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    
    func showAlert(UIView: UIView) {
        self.insertSubview(parentView, aboveSubview: UIView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCitiesCollectionViewCell.id, for: indexPath) as! AlertCitiesCollectionViewCell
        cell.backgroundColor = UIColor(named: "darkBackgroundCellGray")
        cell.cityesLabel.text = recomendedCityes[indexPath.row]
        
        return cell
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: 64, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cityesTextField.text = recomendedCityes[indexPath.row]
    }
}
