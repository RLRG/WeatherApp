//
//  SearchWeatherUseCase.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 01/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift

final class SearchWeatherUseCase {
    private let network: WeatherResultNetwork
    
    init(network: WeatherResultNetwork) {
        self.network = network
    }
    
    func getWeatherResult(withName name: String? = "", withLat lat: Double = 0, withLon lon: Double = 0) -> Observable<WeatherResult> {
        return network.getWeatherResult(withName: name, withLat: lat, withLon: lon)
    }
}
