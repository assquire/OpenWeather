//
//  Constants.swift
//  OpenWeather
//
//  Created by Askar on 03.04.2022.
//

import Foundation
import UIKit

struct K {
    static let textColor = UIColor.white
}

struct MyColors {
    var mainColor: CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

        self.mainColor = CAGradientLayer()
        self.mainColor.colors = [colorTop, colorBottom]
        self.mainColor.locations = [0.0, 1.0]
    }
}
