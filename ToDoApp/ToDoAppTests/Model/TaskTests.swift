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

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task) // проверка что объект существует
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task) // проверка что объект существует
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        // проверяем что установили title
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        // проверяем что установили description
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }

}
