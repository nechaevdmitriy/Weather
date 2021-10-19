//
//  ErrorAlert.swift
//  Weather
//
//  Created by Дмитрий  on 07.10.2021.
//

import Foundation

import UIKit

final class ErrorNetworkAlert: UIAlertController, ErrorAlertProtocol {
    override func viewDidLoad() {
        title = "Нет сети"
        message = "Проверьте подключение к интернету"
        let alertAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        if self.actions.count == 0 {
            self.addAction(alertAction)
        }
    }
}
