//
//  NetworkProvider.swift
//  DancingSteps
//
//  Created by RLRG on 03/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

final class NetworkProvider {
    private let apiEndpoint: String
    public init() {
        apiEndpoint = Constants.weatherAPI
    }
    
    public func makeWeatherResultNetwork() -> WeatherResultNetwork {
        let network = Network<WeatherResult>(apiEndpoint)
        return WeatherResultNetwork(network: network)
    }
}
