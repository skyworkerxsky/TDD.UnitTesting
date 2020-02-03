//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 04.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // проверка title
    func testInitSetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }
    
    // проверка coordinate
    func testInitSetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 1,
            longitude: 2
        )
        
        let location = Location(name: "Foo", coordinate: coordinate)
        
        // проверяем что широта и долгота равны установленным
        XCTAssertEqual(location.coordinate?.latitude, location.coordinate?.latitude)
        XCTAssertEqual(location.coordinate?.longitude, location.coordinate?.longitude)
    }
    
}
