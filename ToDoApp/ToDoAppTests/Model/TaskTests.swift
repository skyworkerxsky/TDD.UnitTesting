//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 04.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {

    // проверка что title не nil
    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task) // проверка что объект существует
    }
    
     // проверка что description не nil
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task) // проверка что объект существует
    }
    
     // проверка что title равен заданному
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        // проверяем что установили title
        XCTAssertEqual(task.title, "Foo")
    }
    
     // проверка что description равег заданному
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        // проверяем что установили description
        XCTAssertTrue(task.description == "Bar")
    }
    
    // проверка что установлена date
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    // проверка что установлена location
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Foo",
                        description: "Bar",
                        location: location)
        
        XCTAssertEqual(location, task.location)
    }

}
