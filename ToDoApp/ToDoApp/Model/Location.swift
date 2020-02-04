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
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
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
