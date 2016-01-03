//
//  WeatherView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// WeatherView inherits NibView, and view is loaded from WeatherView.xib file
class WeatherView: NibView{
  
  /// @IBOutlet
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var temperature: UILabel!
  
  /// Defines xibFileName, from which to load
  override var xibFileName: String{
    return "WeatherView"
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
  var viewModel: WeatherViewModel? {
    didSet {
      
      viewModel?.temperature.bindAndFire {
        [unowned self] in
        self.temperature.text = String($0) + StringUtils.degreeSymbol
      }
      
      viewModel?.icon.bindAndFire {
        [unowned self] in
        self.icon.image = WeatherIcons.icon(String($0))
      }
    }
  }
  
  // Why? i need this "=" for working didSet still a magic
  func attachViewModel(viewModel: WeatherViewModel) {
    self.viewModel = viewModel
  }
  
}
