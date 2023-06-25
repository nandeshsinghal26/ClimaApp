//
//  WeatherModel.swift
//  Clima
//
//  Created by Nandesh Singhal on 22/06/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    var delegate: WeatherDelegate?
    
    func getWeather(queryUrl: String) {
        
        if let url = URL(string: queryUrl) {
        
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                    
                    let decoder = JSONDecoder()
                    do {
                        let weather_data = try decoder.decode(weatherData.self, from: safeData)
                        
                        let weather = WeatherModel(conditionId: weather_data.weather[0].id, temperature: weather_data.main.temp, cityName: weather_data.name)
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
        
                    }
                    catch {
                        print("JSONSerialization error:", error)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    func fetchWeatherDataByName(_ cityName: String) {
        let apiUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=e507f01c3b2c1ba4c021998c0152d411&units=metric"
        let queryUrl = "\(apiUrlString)&q=\(cityName)"
        getWeather(queryUrl: queryUrl)
    }
    
    func fetchWeatherDataByCoord(_ lat: Double, _ lon: Double) {
        let apiUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=e507f01c3b2c1ba4c021998c0152d411&units=metric"
        let queryUrl = "\(apiUrlString)&lat=\(lat)&lon=\(lon)"
        getWeather(queryUrl: queryUrl)
    }
    
    
    
}
