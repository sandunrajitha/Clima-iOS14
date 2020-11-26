//
//  WeatherManager.swift
//  Clima
//
//  Created by Sandun Liyanage on 11/25/20.
//  Copyright © 2020 Sandun Rajitha. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weatherModel: WeatherModel)
}

struct WeatherManager {
    var apiURLFormat = "https://api.openweathermap.org/data/2.5/weather?&appid=489dbf765768d9860727c766d9c3e350&units=metric"
    
    func fetchWeather(_ cityName: String){
        let resourceURL = "\(apiURLFormat)&q=\(cityName)"
        performRequest(urlString: resourceURL)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(urlString: String){
        
        // create URL
        if let url = URL(string: urlString){
            
            //create URL session
            let session = URLSession(configuration: .default)
            
            //give session a task
            let task = session.dataTask(with: url) { (data , response, error) in //trailing closure
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    let decoder = JSONDecoder()
                    
                    do {
                        let weatherData = try decoder.decode(WeatherData.self, from: safeData)
                        
                        let weatherModel = WeatherModel(
                            name: weatherData.name,
                            id: weatherData.weather[0].id,
                            temp: (weatherData.main.temp)
                        )
                        
                        self.delegate?.didUpdateWeather(self, weatherModel)
                        
                    } catch {
                        print(error)
                    }
                }
            }
            
            //start the tast
            task.resume()
        }
    }
    
}
