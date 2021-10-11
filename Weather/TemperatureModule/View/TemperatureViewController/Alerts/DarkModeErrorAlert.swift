//
//  DarkModeErrorAlert.swift
//  Weather
//
//  Created by Дмитрий  on 11.10.2021.
//

import UIKit

final class DarkModeErrorAlert: UIAlertController, ErrorAlertProtocol {
    func show() {
        title = "iOS ниже 13"
        message = "Темная тема доступна только с версии iOS 13 и выше"
        let alertAction = UIAlertAction(title: "Ок", style: .destructive, handler: nil)
        if self.actions.count == 0 {
            self.addAction(alertAction)
        }
    }
}
