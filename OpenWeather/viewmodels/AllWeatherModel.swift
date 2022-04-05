//
//  WeatherData.swift
//  OpenWeather
//
//  Created by Askar on 20.03.2022.
//

import Foundation

struct AllWeatherModel {
    
    var cityName: String
    var countryName: String
    var dailyWeatherList: [DailyWeatherModel]
    
    init(cityName: String, countryCode: String, dailyWeatherList: [DailyWeatherModel]) {
        self.cityName = cityName
        self.countryName = AllWeatherModel.codeToName(with: countryCode)
        self.dailyWeatherList = dailyWeatherList
    }
}

extension AllWeatherModel {
    
    static func codeToName(with code: String) -> String {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: code) ?? "None"
    }
}
