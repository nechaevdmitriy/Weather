//
//  SearchAlertView.swift
//  Weather
//
//  Created by Дмитрий  on 03.09.2021.
//

import UIKit

class SearchAlertControllerView: UIView {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let searchTextField: UITextField = {
            let tf = UITextField()
            tf.borderStyle = .roundedRect
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        let cityesCollectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
        
        let cancelButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.text = "Отмена"
            button.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 14)
            button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
            button.titleLabel?.tintColor = .darkGray
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let acceptButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.text = "Подтвердить"
            button.titleLabel?.font = UIFont(name: "Manrope-Bold", size: 14)
            button.titleLabel?.tintColor = .white
            button.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.6, blue: 1, alpha: 1)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        self.addSubview(searchTextField)
        self.addSubview(cancelButton)
        self.addSubview(acceptButton)
        self.addSubview(cityesCollectionView)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: -20),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            cityesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cityesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cityesCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: -20),
            cityesCollectionView.heightAnchor.constraint(equalToConstant: 20),
            
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: cityesCollectionView.bottomAnchor, constant: -20),
            
            acceptButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            acceptButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 20),
            acceptButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            acceptButton.topAnchor.constraint(equalTo: cityesCollectionView.bottomAnchor, constant: -20)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
