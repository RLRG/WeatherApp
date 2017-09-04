//
//  ImageResultNetwork.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 04/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class ImageResultNetwork {
    private let network: Network<ImageResult>
    
    init(network: Network<ImageResult>) {
        self.network = network
    }
    
    func getImageUrl(withName name: String?, withLat lat: Double, withLon lon: Double) -> Observable<ImageResult> {
        return network.getRequest("?\(flickrURLFromParameters(Constants.methodParameters))&lat=\(lat)&lon=\(lon)&radius=30&radius_units=km")
    }
    
    private func flickrURLFromParameters(_ parameters: [String:String]) -> String {
        var paramString = ""
        for (key, value) in parameters {
            let stringToAppend = "\(key)=\(value)&"
            paramString.append(stringToAppend)
        }
        paramString.remove(at: paramString.index(before: paramString.endIndex))
        return paramString
    }
}


extension ImageResult: ImmutableMappable {
    // JSON -> Object
    public init(map: Map) throws {
        if let photos = map.JSON["photos"] as! [String:Any]?, // swiftlint:disable:this force_cast
            let photo = photos["photo"] as! [[String:Any]]?, // swiftlint:disable:this force_cast
            let url_m = photo[0]["url_m"] {
            url = url_m as! String // swiftlint:disable:this force_cast
        } else {
            url = ""
        }
    }
}
