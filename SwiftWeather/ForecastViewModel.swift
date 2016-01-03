//
//  ForecastViewModel.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation

/// View model for ForecastView
struct ForecastViewModel {
  
  /// Properties
  var weekDay: Observable<String>
  var icon: Observable<String>
  var maxDayTemperature: Observable<Int>
  var minDayTemperature: Observable<Int>
  
  /// Initialization
  init(forecast: Forecast) {
    self.weekDay = Observable(forecast.weekDay)
    self.icon = Observable(forecast.icon)
    self.maxDayTemperature = Observable(forecast.maxDayTemperature)
    self.minDayTemperature = Observable(forecast.minDayTemperature)
  }
}