//
//  WeatherLoader.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation

/// Enum for defining response error
enum ResponseError: Int {
  case WrongJSON, NoInternet, NoSaveData
}

/// typealiases for better reading
typealias WeatherResponse = (Weather?, ResponseError?)->Void
typealias WeatherParams = [String: String]

/// ApiOpenWeatherMapOrgProtocol protocol
protocol ApiOpenWeatherMapOrgProtocol{
  
  func loadFromApiOpenWeatherMapOrg(params: WeatherParams, response: WeatherResponse)
  func parseApiOpenWeatherMapOrgResponse(dictionary : NSDictionary, response: WeatherResponse)
  static func defaultApiOpenWeatherMapOrgParams() -> WeatherParams
  
}

/// Main class for loading wether data. First, try to load data from ApiOpenWeatherMapOrg
/// in case success saves data on disk, in case of failure tries loaded from disk
class WeatherLoader {
  
  /// Tries to load weather data
  func loadWeather(response weatherResponse: WeatherResponse){
    
    loadFromApiOpenWeatherMapOrg(WeatherLoader.defaultApiOpenWeatherMapOrgParams(), response:
      {weather, error -> Void in
        //1. first try load from ApiOpenWeatherMapOrg
        
        if error == nil {
          weatherResponse(weather, error)
          self.saveOnDisk(weather!)
          return
        }
        else{
          //2. Second try load from disk
          self.loadFromDisk(response: {weather, error -> Void in
            
            if error == nil {
              weatherResponse(weather, error)
              return
            }else{
              weatherResponse(nil, ResponseError.NoSaveData)
              return
            }
          })
          
        }
    })
  }
  
  /// Tries to load weather data from disk
  func loadFromDisk(response weatherResponse: WeatherResponse){
    
    let filePath = DicectoryUtils.pathFor(fileName: "fileName")
    
    if let weather = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? Weather{
      weatherResponse(weather, nil)
    }else {
      weatherResponse(nil, ResponseError.NoSaveData)
    }
  }
  
  /// Saves loaded weather data on disk
  func saveOnDisk(weather:Weather){
    let filePath = DicectoryUtils.pathFor(fileName: "fileName")
    NSKeyedArchiver.archiveRootObject(weather, toFile: filePath)
  }
  
}

// MARK: - ApiOpenWeatherMapOrgProtocol
extension WeatherLoader: ApiOpenWeatherMapOrgProtocol {
  
  /// Returns URL from params (propably exists better ways of constructing URL)
  func getURLFromParams(params: WeatherParams)->NSURL{
    
    let url = params["url"]! as String
    let city = params["city"]! as String
    let appID = params["appID"]! as String
    let lang = params["lang"]! as String
    let unit = params["unit"]! as String
    let cnt = params["cnt"]! as String
    
    return NSURL(string: "\(url)q=\(city)&APPID=\(appID)&lang=\(lang)&units=\(unit)&cnt=\(cnt)")!
  }
  
  /// Tries to load weather data according to WeatherParams
  func loadFromApiOpenWeatherMapOrg(params: WeatherParams, response weatherResponse: WeatherResponse){
    
    //let nsURL: NSURL = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Vilnius&APPID=2f2b3c6436693e53b6992c6829218f74&lang=en&units=metric&cnt=5")!
    let nsURL: NSURL = getURLFromParams(params)
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
      (data, response, error)->Void in
      
      var dictionary: NSDictionary?
      
      if let data = data {
        do {
          dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
          self.parseApiOpenWeatherMapOrgResponse(dictionary!, response: weatherResponse);
          
        } catch _ as NSError {
          weatherResponse(nil, ResponseError.NoInternet)
        }
      }
    }
    
    task.resume()
  }
  
  /// Parses loaded JSON data (propably exists JSON parsing libraries)
  func parseApiOpenWeatherMapOrgResponse(dictionary : NSDictionary,
    response weatherResponse: WeatherResponse){
      
      //<Lets show begin
      if let listArray = dictionary["list"] as? NSArray {
        
        let weather = Weather()
        weather.city = "Vilnius"
        weather.forecasts = [Forecast]()
        
        //Parse weather
        if let temp = listArray[0]["temp"]??["day"] as? Double{
          weather.temperature = Int(temp)
        } else {
          weatherResponse(nil, ResponseError.WrongJSON)
          return
        }
        
        if let icon = listArray[0]["weather"]??[0]["icon"] as? String{
          weather.icon = icon
        } else {
          weatherResponse(nil, ResponseError.WrongJSON)
          return
        }
        
        
        //Parse forecasts
        for (index, listItem) in listArray.enumerate() where index > 0 {
          
          print("-------------------")
          print(listItem)
          
          
          let forecast = Forecast()
          
          if let dt = listItem["dt"] as? Double {
            forecast.weekDay = TimeUtils.firstDayLetterFromTime(dt)
          } else {
            weatherResponse(nil, ResponseError.WrongJSON)
            return
          }
          
          if let icon = listItem["weather"]??[0]["icon"] as? String {
            forecast.icon = icon
          } else {
            weatherResponse(nil, ResponseError.WrongJSON)
            return
          }
          
          if let maxTemp = listItem["temp"]??["max"] as? Double{
            forecast.maxDayTemperature = Int(maxTemp)
          } else {
            weatherResponse(nil, ResponseError.WrongJSON)
            return
          }
          
          if let minTemp = listItem["temp"]??["min"] as? Double{
            forecast.minDayTemperature = Int(minTemp)
          } else {
            weatherResponse(nil, ResponseError.WrongJSON)
            return
          }
          
          //Collect all forecsts
          weather.forecasts.append(forecast)
        }
        
        weatherResponse(weather, nil)
        
      }else{
        weatherResponse(nil, ResponseError.WrongJSON)
        return
      }
  }
  
  /// Returns weather parameters as a map
  static func defaultApiOpenWeatherMapOrgParams() -> WeatherParams{
    
    let params: WeatherParams = [
      "url": "http://api.openweathermap.org/data/2.5/forecast/daily?",
      "city": "Vilnius",
      "appID": "2f2b3c6436693e53b6992c6829218f74",
      "lang": "en",
      "unit": "metric",
      "cnt": "5"
    ]
    
    return params
  }
}