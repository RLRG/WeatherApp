//
//  NetworkProviderForFlickr.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 04/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation

final class NetworkProviderForFlickr {
    private let apiEndpoint: String
    public init() {
        apiEndpoint = Constants.flickrAPI
    }
    
    public func makeImageResultNetwork() -> ImageResultNetwork {
        let network = Network<ImageResult>(apiEndpoint)
        return ImageResultNetwork(network: network)
    }
}

