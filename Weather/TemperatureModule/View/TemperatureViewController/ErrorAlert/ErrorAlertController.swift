//
//  ErrorAlertController.swift
//  Weather
//
//  Created by Дмитрий  on 06.10.2021.
//

import UIKit

class ErrorAlert: UIAlertController {
    func show() {
        title = "Нет сети"
        message = "Проверьте подключение к интернету"
        let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        self.addAction(alertAction)
        present(self, animated: true, completion: nil)
    }
}
