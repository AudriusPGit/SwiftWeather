//
//  WeatherViewModel.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// Protocol delegating response of loaded data
protocol WeatherViewModelProtocol: class{
  func onReceivedWeather(error: ResponseError?)
}

/// View model for WeatherView
struct WeatherViewModel {
  
  /// Properties
  let city: Observable<String>
  let icon: Observable<String>
  let temperature: Observable<Int>
  var forecasts: Observable<[ForecastViewModel]>
  
  var weatherLoader: WeatherLoader!
  weak var delegate: WeatherViewModelProtocol?
  
  /// Initialization
  init() {
    self.city = Observable("")
    self.icon = Observable("")
    self.temperature = Observable(0)
    self.forecasts = Observable([])
    
    /// A BIG MESS!
    for var index = 0; index < 4; ++index{
      let forecastViewModel = ForecastViewModel(forecast: Forecast())
      self.forecasts.value.append(forecastViewModel)
    }
    
    weatherLoader = WeatherLoader()
  }
  
  /// Tries to load weather data, reports loading results to delegate
  func loadWeatherData(){
    
    weatherLoader.loadWeather(
      response: {(weather, error) in
        dispatch_async(dispatch_get_main_queue(), {
          
          if error == nil{
            self.temperature.value = (weather?.temperature)!
            self.icon.value = (weather?.icon)!
            
            for var index = 0; index < weather?.forecasts.count; ++index{
              
              let forecast = weather?.forecasts[index]
              let forecastViewModel = self.forecasts.value[index]
              
              forecastViewModel.weekDay.value = (forecast?.weekDay)!
              forecastViewModel.icon.value = (forecast?.icon)!
              forecastViewModel.maxDayTemperature.value = (forecast?.maxDayTemperature)!
              forecastViewModel.minDayTemperature.value = (forecast?.minDayTemperature)!
            }
          }
          
          self.delegate?.onReceivedWeather(error)
        })
        
    })
  }
}