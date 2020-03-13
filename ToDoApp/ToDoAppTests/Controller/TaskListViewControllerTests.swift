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
        super.setUp()
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
    
    // проверяем кнопку что у нас есть кнопка add
    func testTaskVCHasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func sharingNewTaskVC() -> NewTaskViewController {

        guard
            let newTaskButton = sut.navigationItem.rightBarButtonItem,
            let action = newTaskButton.action else {
                return NewTaskViewController()
        }
        
        // добавляем sut в качестве RootVC
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        // пробуем выполнить action c кнопки
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        
        let newTaskVC = sut.presentedViewController as! NewTaskViewController
        return newTaskVC
    }
    
    // при нажатии появляется newtaskVC
    func testAddNewTaskPresentNewTaskVC() {
        let newTaskVC = sharingNewTaskVC()
        XCTAssertNotNil(newTaskVC.titleTF)
    }
    
    // проверка что спользуем один и тот же taskManager
    func testSharesSameTaskMnagerWithNewTaskVC() {
        let newTaskVC = sharingNewTaskVC()
        XCTAssertTrue(newTaskVC.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedTableViewReload() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        // отрабатывает ViewWillAppear
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReload)
    }
    
    func testTapiingCellSendsNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager!.add(task: task)
        
        expectation(forNotification: NSNotification.Name("DidSelectRow notificaation"), object: nil) { notification -> Bool in
            
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else {
                return false
            }
            
            return task == taskFromNotification
            
        }
        
        let tableView = sut.tableView
        tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}

extension TaskListViewControllerTests {
    
    class MockTableView: UITableView {
        var isReload = false
        override func reloadData() {
            isReload = true
        }
    }
    
}
