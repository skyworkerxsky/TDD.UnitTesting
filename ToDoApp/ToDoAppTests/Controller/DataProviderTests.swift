//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 25.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!

    override func setUp() {
        sut = DataProvider()
        tableView = UITableView()
        tableView.dataSource = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // проверяем что у нас 2 секции (задачи и выполненные задачи)
    func testNumberOfSectionsIsTwo() {
        
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTaskCount() {
        
        sut.taskManager = TaskManager()
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        
        tableView.reloadData() // перезагружаем таблицу в ручную
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }

}
