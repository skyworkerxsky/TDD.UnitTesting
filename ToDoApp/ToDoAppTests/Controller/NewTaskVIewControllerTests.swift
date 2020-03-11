//
//  NewTaskVIewControllerTests.swift
//  ToDoAppTests
//
//  Created by Алексей Макаров on 11.03.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import ToDoApp

class NewTaskVIewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    
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
    
}
