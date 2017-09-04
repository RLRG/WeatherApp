//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 03/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenter {
    
    // MARK: - Properties & Initialization
    
    var searchViewControllerImplementation: SearchProtocol!
    let saveNewLatestCityUseCase: SaveNewLatestCityUseCase
    let getLatestCitiesUseCase: GetLatestCitiesUseCase
    let searchWeatherUseCase: SearchWeatherUseCase
    let getImageUrlUseCase: GetImageUrlUseCase
    var latestCities: Variable<[City]> = Variable([])
    var weatherResult: Variable<WeatherResult> = Variable(WeatherResult(temperature: 0, weatherIcon: "", city: City(name: "", timeRequested: Date()), location: Location(lat: 0, lon: 0)))
    var imageResult: Variable<ImageResult> = Variable(ImageResult(url: ""))
    let disposeBag = DisposeBag()
    
    init (saveNewLatestCityUseCase: SaveNewLatestCityUseCase, getLatestCitiesUseCase: GetLatestCitiesUseCase, searchWeatherUseCase: SearchWeatherUseCase, getImageUrlUseCase: GetImageUrlUseCase) {
        self.saveNewLatestCityUseCase = saveNewLatestCityUseCase
        self.getLatestCitiesUseCase = getLatestCitiesUseCase
        self.searchWeatherUseCase = searchWeatherUseCase
        self.getImageUrlUseCase = getImageUrlUseCase
    }
    
    // MARK: - Cities
    
    func saveCity(withName name: String) {
        saveNewLatestCityUseCase.saveCityToDB(cityName: name, date: Date())
            .asObservable().subscribe(
                onError: { (error) in
                    self.searchViewControllerImplementation.newLatestCitySaved(withSuccess: false)
            },
                onCompleted: {
                    self.searchViewControllerImplementation.newLatestCitySaved(withSuccess: true)
            }).disposed(by: disposeBag)
    }
    
    func getCities() {
        getLatestCitiesUseCase.getLatestCitiesInDB().asObservable()
            .subscribe(
                onNext: { (returnedCities) in
                    self.latestCities.value = returnedCities
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error querying latest cities.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted querying latest cities.")
                    #endif
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Weather
    
    func searchWeather(forCityName name: String) {
        searchWeatherUseCase.getWeatherResult(withName: name).asObservable()
            .subscribe(
                onNext: { (returnedWeatherResult) in
                    self.weatherResult.value = returnedWeatherResult
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error requesting weather info.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted requesting weather info.")
                    #endif
            }).disposed(by: disposeBag)
    }
    
    func searchWeatherForCurrentLocation(withLat lat: Double, withLon lon: Double) {
        searchWeatherUseCase.getWeatherResult(withLat: lat, withLon: lon).asObservable()
            .subscribe(
                onNext: { (returnedWeatherResult) in
                    self.weatherResult.value = returnedWeatherResult
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error requesting weather info.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted requesting weather info.")
                    #endif
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Flickr images
    
    func getImageUrl(withName name: String = "", withLat lat: Double = 0, withLon lon: Double = 0) {
        getImageUrlUseCase.getImageUrl(withName: name, withLat: lat, withLon: lon).asObservable()
            .subscribe(
                onNext: { (photo_url) in
                    self.imageResult.value = photo_url
            },
                onError: { (error) in
                    #if DEBUG
                        print("Error requesting image url.")
                    #endif
            },
                onCompleted: {
                    #if DEBUG
                        print("onCompleted requesting image url.")
                    #endif
            }).disposed(by: disposeBag)
    }
}
