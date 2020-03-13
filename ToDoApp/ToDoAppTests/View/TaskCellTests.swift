//
//  TaskCellTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 09.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource // фейковый dataSource для проверки
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // проверяем что у ячейки есть titleLabel
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    // проверяем что titleLabel находится внутри View
    func testCellHasTitleLabelInContentView() {
        // проверка что titleLabel находится внутри View
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    // locationLabel
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationLabelInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    // dataLabel
    func testCellHasDatelabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLabelInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    // проверяем что метод configure устанавливает заголовок
    func testConfigureSetsTitle() {
        let task = Task(title: "Foo")
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    // проверяем что метод configure устанавливает дату
    func testConfigureSetsDate() {
        let task = Task(title: "Foo")
        
        cell.configure(withTask: task)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let date = task.date
        let dateString = dateFormatter.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    // проверяем что метод configure устанавливает локацию
    func testConfigureSetsLocation() {
        
        let location = Location(name: "Foo")
        
        let task = Task(title: "Foo", description: "Bar", location: location)
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    // вынесли параметры нужные для тестирования
    func configureCellWithTask() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
    }
    
    // проверяем что выполненные задачи будут с зачеркнутым стилем
    func testDoneTaskShouldStrikeThrough() {
        configureCellWithTask()
        
        let attributeString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributeString)
    }
    
    // если задача выполнена то удаляем date
    func testDoneTaskDateLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.dateLabel)
    }
    
    // если задача выполнена то удаляем location
    func testDoneTaskLoactionLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.locationLabel)
    }
    
}

extension TaskCellTests {
    // фейковый dataSource для проверки
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
    }
}
