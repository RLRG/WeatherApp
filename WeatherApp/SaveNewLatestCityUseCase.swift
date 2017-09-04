//
//  SaveNewLatestCityUseCase.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift

class SaveNewLatestCityUseCase {
    
    // MARK: Properties & Initialization
    
    private let repository: AbstractRepository<City>
    
    let disposeBag = DisposeBag()
    
    init(repository: AbstractRepository<City>) {
        self.repository = repository
    }
    
    // MARK: Logic of the interactor.
    
    func saveCityToDB(cityName: String, date: Date) -> Observable<Void> {
        
        // Fetching the data. (dependency version principle)
        let completableObservable = Observable<Void>.create { observer in
            
            let city = City(name: cityName, timeRequested: date)
            
            let citySavedObservable = self.repository.save(entity: city)
            citySavedObservable.asObservable()
                .subscribe(
                    onError: { (error) in
                        observer.onError(error)
                },
                    onCompleted: {
                        #if DEBUG
                            print("city saved: \(cityName)")
                        #endif
                        observer.onCompleted()
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
        
        return completableObservable
    }
    
}
