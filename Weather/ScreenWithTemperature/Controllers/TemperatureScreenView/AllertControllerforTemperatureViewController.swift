//
//  AllertController.swift
//  Weather
//
//  Created by Дмитрий  on 03.09.2021.
//

import UIKit

extension TemperatureViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            tf.placeholder = "Tambov"
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                NetworkWeatherManager.networkManager.city = cityName
                self.presenter.getLists(requesType: .city(city: cityName))
                self.presenter.city = cityName
                self.viewDidLoad()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
