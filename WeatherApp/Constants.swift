//
//  Constants.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation

struct Constants {
    static let webViewURL = "https://www.google.es"
    
    // MARK: Weather API
    
    /* Example of API call
       https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=81ad19519a94fc70c162cd0b4d9e564d */
    static let weatherAPI = "https://api.openweathermap.org/data/2.5/"
    static let weatherMethod = "weather"
    static let appIDParameter = "APPID"
    static let appID = "81ad19519a94fc70c162cd0b4d9e564d"
    
    static let weatherURL = "\(weatherMethod)?\(appIDParameter)=\(appID)&units=metric" // "units=metric" in order to have the temperature in Celsius degrees.
    
    // MARK: - Flickr API
    
    /* Example of API call
        https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6d3a9ee3ce484b53f9627d23792ef987&tags=nature%2Cweather%2Cbuilding%2Csun%2Crain%2Cclouds%2Csky%2Csunset%2Csunrise%2Cnight%2Cclouds%2Ctree&accuracy=11&safe_search=1&content_type=1&media=photos&has_geo=1&geo_context=2&extras=url_m&format=json */ // swiftlint:disable:this line_length
    static let flickrAPI = "https://api.flickr.com/services/rest"
    
    static let APIKeyParam = "api_key"
    static let APIKey = "ff612a9ba0ba14eb5d7961e85a75f77f"
    
    static let methodParam = "method"
    static let method = "flickr.photos.search"
    
    static let tagsParam = "tags"
    static let tagsValues = "nature,weather,building,sun,rain,cloud,sky,sunset,sunrise,night,clouds,tree"
    
    static let accuracyParam = "accuracy"
    static let accuracy = "11"
    
    static let safeSearchParam = "safe_search"
    static let safeSearch = "1"
    
    static let contentTypeParam = "content_type"
    static let contentType = "1"
    
    static let mediaParam = "media"
    static let media = "photos"
    
    static let hasGeoParam = "has_geo"
    static let hasGeo = "1"
    
    static let geoContextParam = "geo_context"
    static let geoContext = "2"
    
    static let extrasParam = "extras"
    static let extras = "url_m"
    
    static let formatParam = "format"
    static let format = "json"
    
    static let perPageParam = "per_page"
    static let perPage = "1"
    
    static let noJsonCallBack = "nojsoncallback"
    static let noJsonValue = "1"
    
    static let methodParameters = [
        methodParam: method,
        APIKeyParam: APIKey,
        tagsParam: tagsValues,
        accuracyParam: accuracy,
        safeSearchParam: safeSearch,
        contentTypeParam: contentType,
        mediaParam: media,
        hasGeoParam: hasGeo,
        //geoContextParam: geoContext,
        extrasParam: extras,
        formatParam: format,
        perPageParam: perPage,
        noJsonCallBack: noJsonValue
    ]
}
