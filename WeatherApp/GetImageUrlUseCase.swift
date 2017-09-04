//
//  GetImageUrlUseCase.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 04/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift

final class GetImageUrlUseCase {
    private let network: ImageResultNetwork
    
    init(network: ImageResultNetwork) {
        self.network = network
    }
    
    func getImageUrl(withName name: String? = "", withLat lat: Double = 0, withLon lon: Double = 0) -> Observable<ImageResult> {
        return network.getImageUrl(withName: name, withLat: lat, withLon: lon)
    }
}
