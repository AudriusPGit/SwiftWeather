//
//  WeatherView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

class WeatherView: NibView{
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var temperature: UILabel!
  
  override var xibFileName: String{
    return "WeatherView"
  }
  
  required init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  var viewModel: WeatherViewModel? {
    didSet {
      
      viewModel?.temperature.bindAndFire {
        [unowned self] in
        self.temperature.text = String($0) + StringUtils.degreeSymbol
      }
      
      viewModel?.icon.bindAndFire {
        [unowned self] in
        self.icon.image = WeatherIcons.sharedInstance.icon(String($0))
      }
    }
  }
  
  // Why? i need this =
  func attachViewModel(viewModel: WeatherViewModel) {
    self.viewModel = viewModel
  }
  
}
