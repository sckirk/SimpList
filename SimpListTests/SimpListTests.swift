//
//  SimpListTests.swift
//  SimpListTests
//
//  Created by Suzannah Kirk-Daligcon on 1/9/17.
//  Copyright © 2017 SK. All rights reserved.
//

import XCTest
@testable import SimpList

class SimpListTests: XCTestCase {
        
    //MARK: Item Class Tests
    
    // Confirm that the Item initializer returns an Item object when passed valid parameters.
    func testItemInitializationSucceeds() {
        // One quantity
        let oneQuantityItem = Item.init(name: "One", quantity: 1, location: "natural")
        XCTAssertNotNil(oneQuantityItem)
        
        // Highest quantity
        let sixQuantityItem = Item.init(name: "Six", quantity: 6, location: "natural")
        XCTAssertNotNil(sixQuantityItem)
    }
    
    // Confirm that the Item initialier returns nil when passed a zero quantity, an empty name or an empty location.
    func testItemInitializationFails() {
        // Zero quantity
        let zeroQuantityItem = Item.init(name: "Zero", quantity: 0, location: "natural")
        XCTAssertNil(zeroQuantityItem)
        
        // Quantity exceeds maximum
        let largeQuantityItem = Item.init(name: "TooLargeQuantity", quantity: 7, location: "natural")
        XCTAssertNil(largeQuantityItem)
        
        // Empty String item name
        let emptyStringItemName = Item.init(name: "", quantity: 1, location: "natural")
        XCTAssertNil(emptyStringItemName)
        
        // Empty String item location
        let emptyStringItemLocation = Item.init(name: "Food", quantity: 1, location: "")
        XCTAssertNil(emptyStringItemLocation)
    }
}
