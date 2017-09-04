//
//  WeatherResultNetwork.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 03/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class WeatherResultNetwork {
    private let network: Network<WeatherResult>
    
    init(network: Network<WeatherResult>) {
        self.network = network
    }
    
    func getWeatherResult(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<WeatherResult> {
        if let cityName  = name, cityName != "" {
            return network.getRequest("\(Constants.weatherURL)&q=\(cityName)")
        } else {
            return network.getRequest("\(Constants.weatherURL)&lat=\(lat)&lon=\(lon)")
        }
    }
}


extension WeatherResult: ImmutableMappable {
    // JSON -> Object
    public init(map: Map) throws {
        
        // Temperature
        temperature = try map.value("main.temp")

        // Weather Icon
        if let weatherObjects = map.JSON["weather"] as! NSArray?, // swiftlint:disable:this force_cast
           let weather = weatherObjects[0] as? [String:Any],
           let iconDescription = weather["icon"] {
            weatherIcon = iconDescription as! String // swiftlint:disable:this force_cast
        } else {
            weatherIcon = ""
        }
        
        // City
        if let cityName = map.JSON["name"] {
            city = City(name: cityName as! String, timeRequested: Date()) // swiftlint:disable:this force_cast
        } else {
            city = City(name: "", timeRequested: Date())
        }

        // Location
        if let coord = map.JSON["coord"] as! [String:Any]?, // swiftlint:disable:this force_cast
            let coord_lat = coord["lat"],
            let coord_lon = coord["lon"] {
            location = Location(lat: coord_lat as! Double, lon: coord_lon as! Double) // swiftlint:disable:this force_cast
        } else {
            location = Location(lat: 0, lon: 0)
        }
    }
}
