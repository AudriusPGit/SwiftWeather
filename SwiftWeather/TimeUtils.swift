//
//  TimeUtils.swift
//  SwiftWeather
//
//  Created by Brolis on 1/3/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation


 /// Time related utils
class TimeUtils {
  
  /// Returns week day as a string from timestamp, for instance, "Monday"
  static func dayStringFromTime(unixTime: Double) -> String {
    let date = NSDate(timeIntervalSince1970: unixTime)
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter.stringFromDate(date)
  }
  
  /// Returns day's letter, for instance, "M" for monday
  static func firstDayLetterFromTime(unixTime: Double) -> String {
    let dayString = TimeUtils.dayStringFromTime(unixTime) as NSString
    return dayString.substringWithRange(NSRange(location: 0, length: 1)) as String
  }
}