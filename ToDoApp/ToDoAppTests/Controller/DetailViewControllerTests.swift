//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 09.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // проверяем что у нас есть label
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    // проверяем что у нас есть descriptionLabel
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    // проверяем что у нас есть dateLabel
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    // проверяем что у нас есть locationLabel
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    // проверяем что у нас есть mapView
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    // вспомогательная функция при передаче таска
    func setupTaskAndAppearanceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 57.11216, longitude: 65.586257)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        sut.task = task
        
        // вызываем viewWillAppear, viewDidAppear
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    // проверка что при передаче таска у нас отображается в titleLabel
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    // проверка что при передаче таска у нас отображается в descriptionLabel
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    // проверка что при передаче таска у нас отображается в locationLabel
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    // проверка что при передаче таска у нас отображается в dateLabel
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "01.01.19")
    }
    
    // проверка что при передаче таска устанавливается mapView
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 57.11216, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 65.586257, accuracy: 0.001)
    }
    
}
