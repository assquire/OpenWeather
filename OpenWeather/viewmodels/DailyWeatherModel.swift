//
//  DailyWeatherModel.swift
//  OpenWeather
//
//  Created by Askar on 27.03.2022.
//

import Foundation

struct DailyWeatherModel {
    
    var date: Date
    var sunrise: Date
    var sunset: Date
    let temp: String
    let tempMin: String
    let tempMax: String
    let humidity: Int
    var weatherName: String
    let speed: Float
    let desctiption: String
    
    init(date: Int, sunrise: Int, sunset: Int, temp: Float, tempMin: Float, tempMax: Float, humidity: Int, weatherId: Int, speed: Float, description: String) {
        self.date = DailyWeatherModel.intToDate(date)
        self.sunrise = DailyWeatherModel.intToDate(sunrise)
        self.sunset = DailyWeatherModel.intToDate(sunset)
        self.temp = DailyWeatherModel.numToString(temp)
        self.tempMin = DailyWeatherModel.numToString(tempMin)
        self.tempMax = DailyWeatherModel.numToString(tempMax)
        self.humidity = humidity
        self.weatherName = DailyWeatherModel.idToSystemImage(weatherId)
        self.speed = speed
        self.desctiption = description
    }
}

private extension DailyWeatherModel {
    
    static func numToString(_ num: Float) -> String {
        return String(format: "%.0f", num)
    }
    
    static func intToDate(_ num: Int) -> Date {
        let timeInterval = TimeInterval(num)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        return myNSDate
    }
    
    static func idToSystemImage(_ num: Int) -> String {
        switch num {
        case 800...804:
            return "cloud.bolt"
        case 800:
            return "sun.max"
        case 701...781:
            return "cloud.fog"
        case 600...622:
            return "cloud.snow"
        case 500...531:
            return "cloud.rain"
        case 300...321:
            return "cloud.drizzle"
        case 200...232:
            return "cloud.bolt.rain"
        default:
            return "cloud"
        }
    }
}
