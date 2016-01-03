//
//  ForecastView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit


class ForecastView: NibView{
  
  @IBOutlet weak var weekDay: UILabel!
  @IBOutlet weak var icon: UIImageView!
  
  @IBOutlet weak var maxTemperature: UILabel!
  @IBOutlet weak var minTemperature: UILabel!
  
  
  override var xibFileName: String{
    return "ForecastView"
  }
  
  required init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  
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
  
  // Why? i need this =
  func attachViewModel(viewModel: ForecastViewModel) {
    self.viewModel = viewModel
  }
  
  
}