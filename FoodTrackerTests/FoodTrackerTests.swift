//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by mrensel on 2/8/16.
//  Copyright (c) 2016 mti. All rights reserved.
//

import UIKit
import XCTest

class FoodTrackerTests: XCTestCase {
    
    //MARK: FoodTracker Tests
    func testMealInitialization() {
        //success case
        let potentialItem = Meal(name: "Newest Meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        
        //failure case
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negativeratings are invalid, be positive")
    }
    
}
