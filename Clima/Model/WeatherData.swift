//
//  WeatherData.swift
//  Clima
//
//  Created by Sandun Liyanage on 11/25/20.
//  Copyright © 2020 Sandun Rajitha. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    var name: String
    var main: Main
    var weather: [Weather]
    var sys: Sys
}

struct Main: Codable {
    var temp: Double
}

struct Weather: Codable {
    var id: Int
}

struct Sys: Codable {
    var country: String
}
