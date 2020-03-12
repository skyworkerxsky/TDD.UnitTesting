//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 03.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // проверяем что главный экран это TaskListViewController в navigation
    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navController.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootViewController is TaskListViewController)
    }
    
    

}
