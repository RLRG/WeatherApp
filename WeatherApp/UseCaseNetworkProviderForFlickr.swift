//
//  UseCaseNetworkProviderForFlickr.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 04/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation

class UseCaseNetworkProviderForFlickr {
    private let networkProvider: NetworkProviderForFlickr
    
    public init() {
        networkProvider = NetworkProviderForFlickr()
    }
    
    func makeGetWeatherResult() -> GetImageUrlUseCase {
        return GetImageUrlUseCase(network: networkProvider.makeImageResultNetwork())
    }
    
}
