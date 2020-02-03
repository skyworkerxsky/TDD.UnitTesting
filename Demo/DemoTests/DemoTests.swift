//
//  DemoTests.swift
//  DemoTests
//
//  Created by Алексей Макаров on 03.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import XCTest
@testable import Demo // сообщаем о существовании модул я Demo

class DemoTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: ViewController! // System under test
    
    override func setUp() {
        super.setUp()
        
        sut = ViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // проверяем может ли значение громкости быть меньше нуля
    func testLowestVolumeShouldBeZero() {
        
        sut.setVolume(value: -100)
        
        let volume = sut.volume
        XCTAssert(volume == 0, "lowes value should be eqal 0.")
    }
    
    // проверяем может ли значение громкости быть больше ста
    func testHighestVolumeShouldBe100() {
        
        sut.setVolume(value: 200)
        
        // устанавливаем значение
        let volume = sut.volume
        XCTAssert(volume == 100, "Highest value should be eqal 100.")
    }
    
    // проверка что строки равны
    func testCharsInStringsAreTheSame() {
        
        // given
        let string1 = "qwerty"
        let string2 = "ytrewq"
        
        // when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        
        // then
        XCTAssert(bool, "Characters should be the same in two strings")
    }
    
    // проверка что строки разные
    func testCharsInStringsAreDifferent() {
        
        // given
        let string1 = "qwerty1"
        let string2 = "qweqwr"
        
        // when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        
        // then
        XCTAssert(!bool, "Characters should be different in two strings")
    }
    
}
