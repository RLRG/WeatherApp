//
//  RMCity.swift
//  WeatherApp
//
//  Created by Rodrigo López-Romero Guijarro on 02/09/2017.
//  Copyright © 2017 Rodrigo López-Romero Guijarro. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RMCity: Object {
    dynamic var name: String = ""
    dynamic var timeRequested: Date = Date()
    
    override class func primaryKey() -> String? {
        return "timeRequested"
    }
}


extension RMCity: DomainConvertibleType {
    func asDomain() -> City {
        return City(name: name,
                     timeRequested: timeRequested)
    }
}

extension City: RealmRepresentable {
    func asRealm() -> RMCity {
        return RMCity.build { object in
            object.name = name
            object.timeRequested = timeRequested
        }
    }
}
