//
//  RegistrationTests.swift
//  FrontendUnitTests
//
//  Created by Jackson Kurtz on 4/6/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
import XCTest
@testable import Frontend

class RegistrationTests: XCTestCase {
    
    func testValidRegistration() {
        let vc = RegistrationViewController()

        let username = "test user"
        let pass = "password"
        let conf_pass = "password"
        let phone_number = "1111"
        
        let result = vc.isValidRegistration(username: username, pass: pass, conf_pass: conf_pass, phone_number: phone_number )
        
        XCTAssertTrue(result)
    }
    func testInvalidRegistration() {
        let vc = RegistrationViewController()
        
        let username = "other user"
        let pass = "password"
        let conf_pass = "non-matching password"
        let phone_number = "2222"
        
        let result = vc.isValidRegistration(username: username, pass: pass, conf_pass: conf_pass, phone_number: phone_number )
        
        XCTAssertFalse(result)
    }
    
}
