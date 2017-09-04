//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import UIKit
import SearchTextField
import CoreLocation
#if WeatherAppLAB
    import FLEX
#endif

class SearchViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties & Initialization
    
    @IBOutlet weak var cityTextBox: SearchTextField!
    @IBOutlet weak var debugButton: UIButton!
    
    var presenter: SearchPresenter!
    let disposeBag = DisposeBag()
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    
    let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextBox.delegate = self
        
        // LocationManager config
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        
        // Displaying the DEBUG button when we are running the LAB target.
        #if WeatherAppLAB
            debugButton.isHidden = false
        #else
            debugButton.isHidden = true
        #endif
        
        // Keyboard
        self.hideKeyboardWhenTappedAround()
        
        // Latest cities
        setupTextField()
        setupCitiesDataObserver()
        presenter.getCities()
        
        // Weather & ImageURL results
        setupWeatherAndImageURLObservers()
        
        // UIActivityIndicator
        loadingSpinner.color = UIColor.purple
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - (self.navigationController?.navigationBar.bounds.height)!)
        loadingSpinner.accessibilityIdentifier = "loadingIndicator"
        self.view.addSubview(loadingSpinner)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        cityTextBox.text = ""
        enableSuggestionsListTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupTextField() {
        cityTextBox.theme.font = UIFont.systemFont(ofSize: 12)
        cityTextBox.theme.bgColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        cityTextBox.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        cityTextBox.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        cityTextBox.theme.cellHeight = 50
        
        cityTextBox.maxNumberOfResults = 3
        cityTextBox.startVisible = true
        
        cityTextBox.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.cityTextBox.text = item.title
        }
    }
    
    func disableSuggestionsListTextField() {
        cityTextBox.maxNumberOfResults = 0
        cityTextBox.startVisible = false
        cityTextBox.theme.cellHeight = 0
    }
    
    func enableSuggestionsListTextField() {
        cityTextBox.maxNumberOfResults = 3
        cityTextBox.startVisible = true
        cityTextBox.theme.cellHeight = 50
    }
    
    // MARK: - Data Observers
    
    func setupCitiesDataObserver() {
        presenter.latestCities.asObservable()
            .subscribe({ _ in
                var cityArray: [SearchTextFieldItem] = [SearchTextFieldItem]()
                for city in self.presenter.latestCities.value {
                    let searchTextFieldItem = SearchTextFieldItem(title: city.name)
                    cityArray.append(searchTextFieldItem)
                }
                cityArray.reverse() // In order to get the lastest requested cities.
                self.cityTextBox.filterItems(cityArray)
            })
            .disposed(by: disposeBag)
    }
    
    func setupWeatherAndImageURLObservers() {
        
        let weatherObservable = presenter.weatherResult.asObservable()
        let imageObservable = presenter.imageResult.asObservable()
        
        Observable
            .zip(weatherObservable, imageObservable) { (weather, image) throws -> (WeatherResult, ImageResult) in
                return (weather,image)
            }.subscribe({ _ in
                if ( (self.presenter.weatherResult.value.location.lat != 0 || self.presenter.weatherResult.value.location.lon != 0) && (self.presenter.imageResult.value.url != "")) {
                    DispatchQueue.main.async {
                        
                        self.loadingSpinner.stopAnimating()
                        
                        let resultViewController = UIStoryboard(name: "Main", bundle: nil)
                            .instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController // swiftlint:disable:this force_cast
                        resultViewController.resultObject = self.presenter.weatherResult.value
                        resultViewController.resultImage = self.presenter.imageResult.value
                        self.navigationController?.pushViewController(resultViewController, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func searchWeatherForCity(_ sender: Any) {
        if let cityName = cityTextBox.text, cityName != "" {
            loadingSpinner.startAnimating()
            disableSuggestionsListTextField()
            presenter.saveCity(withName: cityName)
            presenter.searchWeather(forCityName: cityName)
            presenter.getImageUrl()
        } else {
            AlertsManager.alert(caller: self, message: "Please, provide a city name to request the weather information and try again", title: "No city entered") {
            }
        }
    }
    
    @IBAction func searchWeatherForCurrentLocation(_ sender: Any) {
        if let lat = lastLocation?.coordinate.latitude,
            let lon = lastLocation?.coordinate.longitude {
            loadingSpinner.startAnimating()
            disableSuggestionsListTextField()
            presenter.searchWeatherForCurrentLocation(withLat: lat, withLon: lon)
            presenter.getImageUrl(withName: "", withLat: lat, withLon: lon)
        } else {
            AlertsManager.alert(caller: self, message: "Please, check that you have allowed your location services and try again", title: "Operation error") {
            }
        }
        
    }
    
    @IBAction func openWebView(_ sender: Any) {
        let webViewVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController // swiftlint:disable:this force_cast
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func openFLEX(_ sender: Any) {
        // Displaying FLEX debugger.
        #if WeatherAppLAB
            FLEXManager.shared().showExplorer()
        #endif
    }
}

extension SearchViewController : SearchProtocol {
    func newLatestCitySaved(withSuccess success: Bool) {
        if success {
            #if DEBUG
                print("The city has been saved successfully!")
            #endif
        } else {
            #if DEBUG
                print("ERROR: The city could not be saved successfully")
            #endif
        }
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
        AlertsManager.alert(caller: self, message: "Please, check that you have allowed your location services", title: "Operation error") {
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        lastLocation = newLocation
    }
}
