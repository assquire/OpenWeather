//
//  WeatherResponse.swift
//  OpenWeather
//
//  Created by Askar on 20.03.2022.
//

import Foundation

struct WeatherResponse: Decodable {
    let city: City
    let list: [ListItem]
}

struct ListItem: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let humidity: Int
    let weather: [WeatherItem]
    let speed: Float
}

struct Temp: Decodable {
    let day: Float
    let min: Float
    let max: Float
}

struct WeatherItem: Decodable {
    let id: Int
    let description: String
}

struct City: Decodable {
    let name: String
    let country: String
}
