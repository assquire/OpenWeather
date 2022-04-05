//
//  WeatherManager.swift
//  OpenWeather
//
//  Created by Askar on 27.03.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: AllWeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchRequest(cityName: String) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/forecast/daily?q=\(cityName)&cnt=7&units=metric")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
    
        performRequest(request: request)
    }
    
    func fetchRequest(lon: Double, lat: Double) {
        let request = NSMutableURLRequest(url: URL(string: "https://community-open-weather-map.p.rapidapi.com/forecast/daily?lat=\(lat)&lon=\(lon)&cnt=7&units=metric")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        performRequest(request: request)
    }
    
    func performRequest(request: NSMutableURLRequest) {
        let headers = [
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
            "x-rapidapi-key": "87b21b9c74mshbe2d43935290d2dp1635bcjsnbea7d0a724e3"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {fatalError()}
            if let weather = parseJSON(data) {
                delegate?.didUpdateWeather(self, weather: weather)
            } else {
                print("cannot parse JSON")
            }
        })
        dataTask.resume()
    }
    
    func parseJSON(_ wearherData: Data) -> AllWeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: wearherData)
            let cityName = decodedData.city.name
            let countryCode = decodedData.city.country
            var weatherList: [DailyWeatherModel] = []
            for i in 0..<decodedData.list.count {
                let listItem = decodedData.list[i]
                let weatherItem = DailyWeatherModel(
                    date: listItem.dt,
                    sunrise: listItem.sunrise,
                    sunset: listItem.sunset,
                    temp: listItem.temp.day,
                    tempMin: listItem.temp.min,
                    tempMax: listItem.temp.max,
                    humidity: listItem.humidity,
                    weatherId: listItem.weather[0].id,
                    speed: listItem.speed,
                    description: listItem.weather[0].description
                )
                weatherList.append(weatherItem)
            }
            let weather = AllWeatherModel(
                cityName: cityName,
                countryCode: countryCode,
                dailyWeatherList: weatherList
            )
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
