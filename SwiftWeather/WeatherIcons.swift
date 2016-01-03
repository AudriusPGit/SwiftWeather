//
//  WeatherIcons.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// Responsible to return weather icons either from http://openweathermap.org/weather-conditions or loaded
/// from disk.
class WeatherIcons {
  
  /// Returns weather icon as UIImage?
  static func icon(iconName: String)->UIImage?{
    
    let image = iconFromApiOpenWeatherMapOrg(iconName);
    
    if let image = image {
      saveIconOnDisk(imageData: UIImagePNGRepresentation(image)!, iconName: iconName)
      return image
    }
    else if let image = loadIconFromDisk(iconName){
      return image
    }
    
    return nil
  }
  
  /// Returns weather icon from http://openweathermap.org/weather-conditions
  static func iconFromApiOpenWeatherMapOrg(iconName: String)->UIImage?{
    //<http://openweathermap.org/weather-conditions
    
    let url = NSURL(string: "http://openweathermap.org/img/w/\(iconName).png")
    
    let data: NSData? = NSData(contentsOfURL : url!)
    
    if let data = data {
      let image = UIImage(data : data)
      return image
    }
    
    return nil
  }
  
  /// Saves icon on disk
 static  func saveIconOnDisk(imageData data: NSData, iconName: String){
    data.writeToFile(DicectoryUtils.pathFor(fileName: iconName), atomically: true)
  }
  
  /// Returns saved weather icon from disk
 static func loadIconFromDisk(iconName: String)->UIImage?{
    let loadedImage = UIImage(contentsOfFile: DicectoryUtils.pathFor(fileName: iconName))
    
    return loadedImage
  }
  
}