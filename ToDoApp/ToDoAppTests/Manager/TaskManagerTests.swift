//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 04.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUp() {
        super.setUp()
        sut = TaskManager() // создаем менеджер
    }
    
    override func tearDown() {
        sut .removeAll()
        sut = nil // удаляем менеджер после прогонки тестов
        super.tearDown()
    }
    
    // при запуске кол-во тасков равно нулю
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    // кол-во выполненных задач
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    // при добавлении увеличиваем счетчик задач
    func testAddTaskIncrementTaskCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    // проверка добавленной задачи по индексу
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    // проверка что счетчики меняются когда задача переходит в выполненные
    func testCheckTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    // проверка что удаляются отмеченные задачи
    func testCheckTaskRemoveFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0) // первый элемент (Foo) уходит в doneTasks
        
        // проверяем что в tasks остался Bar
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    // проверка что  задачи переносятся отмеченные в doneTasks
    func testDoneTaskAtReturnCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    // проверка что все задачи удаляются
    func testRemoveAllResultsCountBeZero() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Bar"))
        sut.checkTask(at: 0) // первый элемент (Foo) уходит в doneTasks
        
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    // проверка что добавляем уникальный task
    func testAddingSameObjectDoesNotInrementCount() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1)
    }
    
    func testWhenTaskManagerRecreatedCavedTasksShouldBeEqual() {
        var taskManager: TaskManager! = TaskManager()
        let task = Task(title: "Foo")
        let task1 = Task(title: "Bar")
        
        taskManager.add(task: task)
        taskManager.add(task: task1)
        
        NotificationCenter.default.post(name: UIApplication.willResignActiveNotification, object: nil)
        
        taskManager = nil
        
        taskManager = TaskManager()
        
        XCTAssertEqual(taskManager.tasksCount, 2)
        XCTAssertEqual(taskManager.task(at: 0), task)
        XCTAssertEqual(taskManager.task(at: 1), task1)
    }
    
}
