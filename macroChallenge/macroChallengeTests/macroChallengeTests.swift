//
//  macroChallengeTests.swift
//  macroChallengeTests
//
//  Created by rebeca primo on 22/05/23.
//

import XCTest
@testable import macroChallenge

final class macroChallengeTests: XCTestCase {

    var sut: Manager!
    
    override func setUp() {
        super.setUp()
        sut = Manager()
    }

    
    func test_verifyAllButtonsArePressed_oneButton() {
        sut.sendData(buttonId: 1)
        let result = sut.verifyAllButtonsArePressed()
        XCTAssertFalse(result)
    }
    
    //fazer esse teste mais dividido: false de 1 a 20 e true 21
    func test_verifyAllButtonsArePressed_allButtons() {
        var result = false
        
        for i in 1...21 {
            sut.sendData(buttonId: i)
            result = sut.verifyAllButtonsArePressed()
        }
        XCTAssertTrue(result)
    }
    
    func test_verifyAllButtonsArePressed_allButtons2() {
        var result = false
        var i = 1, n = 20
        
        while (i <= n) {
            sut.sendData(buttonId: i)
            result = sut.verifyAllButtonsArePressed()
            i = i + 1
        }
        XCTAssertFalse(result)
        
        
    }
    
    
    //teste de sendData(): buttonStates antes tem que estar vazio e depois com valor. Inclusive ele não está sobreescrevendo valores.
    func test_sendData() {
//        sut.buttonStates
//        print(sut.buttonStates)
        XCTAssertEqual(sut.buttonStates, [:])
        sut.sendData(buttonId: 1)
        XCTAssertEqual(sut.buttonStates, [1 : true])
        sut.sendData(buttonId: 2)
        XCTAssertEqual(sut.buttonStates, [1 : true, 2 : true])
    }
}
