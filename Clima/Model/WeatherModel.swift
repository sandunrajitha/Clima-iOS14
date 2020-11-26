//
//  WeatherModel.swift
//  Clima
//
//  Created by Sandun Liyanage on 11/26/20.
//  Copyright © 2020 Sandun Rajitha. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name: String
    let id: Int
    let temp: Double
    let country: String
    
    var city: String{
        return String("\(name),\(country)")
    }
    var temperatureString: String{ //calculated property
        return String(format: "%.1f", temp)
    }
    var symbol: String{ //calculated property
        switch id {
        case 200...232:
            return "cloud.bolt"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
        
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud"
            
        default:
            return "cloud"
        }
    }
}
