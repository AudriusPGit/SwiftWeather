//
//  Weather.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation

class Weather: NSCoder{
  var city: String = ""
  var icon: String = ""
  var temperature: Int = 0
  
  var forecasts: [Forecast] = []
  
  required convenience init?(coder decoder: NSCoder) {
    
    self.init()
    
    if let city = decoder.decodeObjectForKey("city") as? String{
      self.city = city
    } else {
      return nil
    }
    
    if let icon = decoder.decodeObjectForKey("icon") as? String{
      self.icon = icon
    } else {
      return nil
    }
    
    if let temperature = decoder.decodeObjectForKey("temperature") as? Int{
      self.temperature = temperature
    } else {
      return nil
    }
    
    if let archiverForecats = decoder.decodeObjectForKey("archiverForecats") as? [Forecast]{
      self.forecasts = archiverForecats
    } else {
      return nil
    }
  }
  
  func encodeWithCoder(coder: NSCoder) {
    coder.encodeObject(self.city, forKey: "city")
    coder.encodeObject(self.icon, forKey: "icon")
    coder.encodeObject(self.temperature, forKey: "temperature")
    
    let archiverForecats = NSKeyedArchiver.archivedDataWithRootObject(forecasts)
    coder.encodeObject(archiverForecats, forKey: "archiverForecats")
  }
  
}