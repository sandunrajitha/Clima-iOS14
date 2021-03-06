//
//  WeatherManager.swift
//  Clima
//
//  Created by Sandun Liyanage on 11/25/20.
//  Copyright © 2020 Sandun Rajitha. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weatherModel: WeatherModel)
    func didFailWithError(_ error: Error)
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        /* Returns an array containing substrings from the string that have been divided by characters in the given set. */
        return components.filter { !$0.isEmpty }.joined(separator: " ")
        /* Returns a new string by concatenating the elements of the sequence, adding the given separator between each element. */
        
        /* func filter(_ isIncluded: (Character) throws -> Bool) rethrows -> String
         Returns a new collection of the same type containing, in order, the elements of the original collection that satisfy the given predicate. in this case it returns non empty elements of the "components" */
    }
}

struct WeatherManager {
    
    let apiURLFormat = "https://api.openweathermap.org/data/2.5/weather?&appid=489dbf765768d9860727c766d9c3e350&units=metric"
    
    func fetchWeather(for cityName: String){
        
        var city = cityName.condenseWhitespace()
        city = String(city.replacingOccurrences(of: " ", with: "+"))
        
        let resourceURL = "\(apiURLFormat)&q=\(city)"
        
        performRequest(with: resourceURL)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlString: String){
        
        // create URL
        if let url = URL(string: urlString){
            
            //create URL session
            let session = URLSession(configuration: .default)
            
            //give session a task
            let task = session.dataTask(with: url) { (data , response, error) in //trailing closure
                
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data{
                    let decoder = JSONDecoder()
                    
                    do {
                        let weatherData = try decoder.decode(WeatherData.self, from: safeData)
                        
                        let weatherModel = WeatherModel(
                            name: weatherData.name,
                            id: weatherData.weather[0].id,
                            temp: (weatherData.main.temp),
                            country: weatherData.sys.country
                        )
                        
                        self.delegate?.didUpdateWeather(self, weatherModel)
                        
                    } catch {
                        self.delegate?.didFailWithError(error)
                    }
                }
            }
            
            //start the tast
            task.resume()
        }
    }
    
}

extension WeatherManager{
    
    func fetchWeather(with coordinates: CLLocationCoordinate2D) {
        let resourceURL = "\(apiURLFormat)&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)"
        
        performRequest(with: resourceURL)
    }
}
