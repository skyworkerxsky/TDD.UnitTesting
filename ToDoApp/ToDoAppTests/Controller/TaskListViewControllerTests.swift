//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 12.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // проверяем что у нас есть tableView после того как загрузили проект
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    // проверям dataProvider
    func testWhenViewIsLoadedDataProviderNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    // проверяем установлен ли delegate
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    // проверяем установлен ли dataSource
     func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
     }
    
    // проверяем что делегатом и dataSource является наш tableView
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSourse(){
        XCTAssertEqual(
            sut.tableView.delegate as? DataProvider,
            sut.tableView.dataSource as? DataProvider
        )
    }
    
}
