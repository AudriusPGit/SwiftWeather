//
//  Forecast.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation

class Forecast: NSCoder {
  var weekDay: String = ""
  var icon: String = ""
  var maxDayTemperature: Int = 0
  var minDayTemperature: Int = 0
  
  required convenience init?(coder decoder: NSCoder) {
    
    self.init()
    
    if let weekDay = decoder.decodeObjectForKey("weekDay") as? String{
      self.weekDay = weekDay
    } else {
      return nil
    }
    
    if let icon = decoder.decodeObjectForKey("icon") as? String{
      self.icon = icon
    } else {
      return nil
    }
    
    if let maxDayTemperature = decoder.decodeObjectForKey("maxDayTemperature") as? Int{
      self.maxDayTemperature = maxDayTemperature
    } else {
      return nil
    }
    
    if let minDayTemperature = decoder.decodeObjectForKey("minDayTemperature") as? Int{
      self.minDayTemperature = minDayTemperature
    } else {
      return nil
    }
  }
  
  func encodeWithCoder(coder: NSCoder) {
    coder.encodeObject(self.weekDay, forKey: "weekDay")
    coder.encodeObject(self.icon, forKey: "icon")
    coder.encodeObject(self.maxDayTemperature, forKey: "maxDayTemperature")
    coder.encodeObject(self.minDayTemperature, forKey: "minDayTemperature")
  }
}