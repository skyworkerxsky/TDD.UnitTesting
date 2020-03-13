//
//  Location.swift
//  ToDoApp
//
//  Created by Алексей Макаров on 04.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    var dict: [String: Any] {
        var dict: [String: Any] = [:]
        dict["name"] = name
        if let coordinate = coordinate {
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location {
    typealias PlistDict = [String: Any]
    init?(dict: PlistDict) {
        self.name = dict["name"] as! String
        if
            let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}

// переопределяем равенство двух location
extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        if  lhs.coordinate?.latitude == rhs.coordinate?.latitude,
            lhs.coordinate?.longitude == rhs.coordinate?.longitude,
            lhs.name == rhs.name { return true }
        
        return false
    }
}
