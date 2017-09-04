//
//  UseCaseNetworkProvider.swift
//  DancingSteps
//
//  Created by RLRG on 07/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation

class UseCaseNetworkProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    func makeGetWeatherResult() -> SearchWeatherUseCase {
        return SearchWeatherUseCase(network: networkProvider.makeWeatherResultNetwork())
    }

}

