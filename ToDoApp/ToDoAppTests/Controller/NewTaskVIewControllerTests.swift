//
//  NewTaskVIewControllerTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 11.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class NewTaskVIewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // проверяем есть ли текстовое поле для title в контроллере
    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTF.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли текстовое поле для location в контроллере
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTF.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли текстовое поле для date в контроллере
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTF.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли текстовое поле для address в контроллере
    func testHasAddressTextField() {
        XCTAssertTrue(sut.addressTF.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли текстовое поле для description в контроллере
    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTF.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли кнопка save
    func testHasSaveButtonField() {
        XCTAssertTrue(sut.saveBtn.isDescendant(of: sut.view))
    }
    
    // проверяем есть ли кнопка save
    func testHasCanselButtonField() {
        XCTAssertTrue(sut.canselBtn.isDescendant(of: sut.view))
    }
    
    // проверка что при сохранении таск будет использоватья геокодер чтобы трансформаривать данные в координаты которые будем использовать дна карте
    func testSaveUsesGeocoderToConvertCoordinateFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.01.19")
        sut.titleTF.text = "Foo"
        sut.locationTF.text = "Bar"
        sut.dateTF.text = "01.01.19"
        sut.addressTF.text = "Тюмень"
        sut.descriptionTF.text = "Baz"
        
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save() // сохраняем
        
        let coordinate = CLLocationCoordinate2DMake(57.1522719, 65.5327956)
        let location = Location(name: "Bar", coordinate: coordinate)
        let genertedTask = Task(title: "Foo", description: "Baz", location: location, date: date)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, genertedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        
        let saveBtn = sut.saveBtn
        
        guard let actions = saveBtn?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Тюмень"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error != nil { return }
            
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard
                let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude else {
                    XCTFail()
                    return
                }
            
            XCTAssertEqual(latitude, 57.1522719)
            XCTAssertEqual(longitude, 65.5327956)
            
            geocoderAnswer.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

// переопределяем Geocoder
extension NewTaskVIewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
}

// вспомогательный класс для теста геокодера
class MockCLPlacemark: CLPlacemark {
    
    var mockCoordinate: CLLocationCoordinate2D!
    
    override var location: CLLocation? {
        return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
    }
}
