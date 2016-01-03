//
//  SwiftWeatherTests.swift
//  SwiftWeatherTests
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

/*
loadFromDisk
loadFromApiOpenWeatherMapOrg

*/


import XCTest
@testable import SwiftWeather

class SwiftWeatherTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  
  func testWeatherDataApiOpenWeatherMapOrg(){
    
    let loader = WeatherLoader()
    let expectation = expectationWithDescription("testWeatherDataApiOpenWeatherMapOrg")
    
    loader.loadFromApiOpenWeatherMapOrg(WeatherLoader.defaultApiOpenWeatherMapOrgParams(), response:
      {weather, error -> Void in
        
        if(error == nil){
          expectation.fulfill()
        }
        else{
          XCTAssert(false, "Can't load data from internet!")
        }
        
      }
    )
    
    waitForExpectationsWithTimeout(10) { // 3
      error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  
  func testWeatherDataFromDisk(){
    let loader = WeatherLoader()
    
    loader.loadFromDisk(response: {weather, error in
      
      XCTAssert(error == nil, "Can't load data from disk")
      
    })
  }
  
}
