//
//  ErrorAlert.swift
//  Weather
//
//  Created by Дмитрий  on 07.10.2021.
//

import Foundation

import UIKit

class ErrorAlert: UIAlertController {
    func show() {
        title = "Нет сети"
        message = "Проверьте подключение к интернету"
        let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        self.addAction(alertAction)
    }
}
