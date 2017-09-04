//
//  ApplicationConf.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 03/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import Realm
import RxSwift
import UIKit

final class Application {
    static let shared = Application() // singleton.
    
    func cleanArchitectureConfiguration(storyboard: UIStoryboard, mainWindow: UIWindow) {
        
        // Search screen
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController // swiftlint:disable:this force_cast
        let searchVC = navigationController.topViewController as! SearchViewController // swiftlint:disable:this force_cast
        let realmCityRepo = RealmRepo<City>()
        let saveNewLatestCityUseCase = SaveNewLatestCityUseCase(repository: realmCityRepo)
        let getLatestCitiesUseCase = GetLatestCitiesUseCase(repository: realmCityRepo)
        let useCaseNetworkProvider = UseCaseNetworkProvider()
        let searchWeatherUseCase = useCaseNetworkProvider.makeGetWeatherResult()
        let useCaseNetworkProviderForFlickr = UseCaseNetworkProviderForFlickr()
        let getImageUrlUseCase = useCaseNetworkProviderForFlickr.makeGetWeatherResult()
        let presenter = SearchPresenter(saveNewLatestCityUseCase: saveNewLatestCityUseCase, getLatestCitiesUseCase: getLatestCitiesUseCase, searchWeatherUseCase: searchWeatherUseCase, getImageUrlUseCase: getImageUrlUseCase)
        searchVC.presenter = presenter
        presenter.searchViewControllerImplementation = searchVC
        
        // START THE APP !
        mainWindow.rootViewController = navigationController
        mainWindow.makeKeyAndVisible()
    }
}
