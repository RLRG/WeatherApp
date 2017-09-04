//
//  Constants.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation

struct Constants {
    static let webViewURL = "https://www.google.es"
    
    // MARK: Weather API
    
    /* Example of API call
       https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=81ad19519a94fc70c162cd0b4d9e564d */
    static let weatherAPI = "https://api.openweathermap.org/data/2.5/"
    static let weatherMethod = "weather"
    static let appIDParameter = "APPID"
    static let appID = "81ad19519a94fc70c162cd0b4d9e564d"
    
    static let weatherURL = "\(weatherMethod)?\(appIDParameter)=\(appID)&units=metric" // "units=metric" in order to have the temperature in Celsius degrees.
    
}
