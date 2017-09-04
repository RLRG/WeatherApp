//
//  GetLastestCitiesUseCase.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift

class GetLatestCitiesUseCase {
    
    private let repository: AbstractRepository<City>
    
    init(repository: AbstractRepository<City>) {
        self.repository = repository
    }
    
    func getLatestCitiesInDB() -> Observable<[City]> {
        return repository.queryAll()
    }
}
