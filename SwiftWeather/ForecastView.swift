//
//  ForecastView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// ForecastView inherits NibView, and view is loaded from ForecastView.xib file
class ForecastView: NibView{
  
  /// @IBOutlet
  
  @IBOutlet weak var weekDay: UILabel!
  @IBOutlet weak var icon: UIImageView!
  
  @IBOutlet weak var maxTemperature: UILabel!
  @IBOutlet weak var minTemperature: UILabel!
  
  
  /// Defines xibFileName, from which to load
  override var xibFileName: String{
    return "ForecastView"
  }
  
  /// Initilization
  required init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  /// Initilization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  /// view model
  var viewModel: ForecastViewModel? {
    didSet {
      
      viewModel?.weekDay.bindAndFire {
        [unowned self] in
        self.weekDay.text = String($0)
      }
      
      viewModel?.icon.bindAndFire {
        [unowned self] in
        self.icon.image = WeatherIcons.sharedInstance.icon(String($0))
      }
      
      viewModel?.maxDayTemperature.bindAndFire {
        [unowned self] in
        self.maxTemperature.text = String($0) + StringUtils.degreeSymbol
      }
      
      viewModel?.minDayTemperature.bindAndFire {
        [unowned self] in
        self.minTemperature.text = String($0) + StringUtils.degreeSymbol
      }
      
    }
  }
  
  // Why? i need this "=" for working didSet still a magic
  func attachViewModel(viewModel: ForecastViewModel) {
    self.viewModel = viewModel
  }
  
  
}