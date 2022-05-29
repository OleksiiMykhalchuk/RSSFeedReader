//
//  Alerts.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/29/22.
//

import Foundation
import UIKit

class Alerts {
    class func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default)
        alert.addAction(action)
    }
}
