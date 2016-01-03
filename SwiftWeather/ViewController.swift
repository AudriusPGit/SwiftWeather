//
//  ViewController.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// View controller of Main.storyboard
class ViewController: UIViewController {
  
  /// @IBOutlet
  @IBOutlet weak var weatherView: WeatherView!
  @IBOutlet weak var forecastViews: UIStackView!
  @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
  
  /// View model
  var weatherViewModel: WeatherViewModel!
  
  /// Initialization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "onApplicationDidBecomeActive:", name:UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    weatherViewModel = WeatherViewModel()
    weatherViewModel.delegate = self
    
    //attachements
    weatherView?.attachViewModel(weatherViewModel)
    
    /// A BIG MESS!
    for var index = 0; index < forecastViews.arrangedSubviews.count; ++index {
      let forecastView = forecastViews.arrangedSubviews[index] as! ForecastView
      forecastView.attachViewModel(weatherViewModel.forecasts.value[index])
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /// Starts load weather
  func startLoadWeather(){
    weatherViewModel?.loadWeatherData()
    activitySpinner?.startAnimating()
  }
  
  func onApplicationDidBecomeActive(notification: NSNotification)->Void{
    startLoadWeather()
  }
}

// MARK: - WeatherViewModelProtocol
extension ViewController: WeatherViewModelProtocol{
  
  func onReceivedWeather(
    error: ResponseError?)->Void{
    
    if error != nil {
      
      let alert = UIAlertController(title: "Error", message: "No Data! Check internet connection!", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default,
        handler: { [unowned self] acction -> Void in
          self.startLoadWeather()
        }))
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    }
    
    activitySpinner?.stopAnimating()
  }
}


