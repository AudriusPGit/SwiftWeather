//
//  NibView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// Loaded view from xib file, requires overridde nibName property in subclasses
class NibView : UIView{
  
  /// Returns xib file name, must be overridden in subclasses
  var xibFileName: String{
    fatalError("This property must be overridden")
  }
  
  /// Initilization
  required override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupXibView(xibFileName)
  }
  
  /// Initilization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupXibView(xibFileName)
  }
  
  /// Loads view from xib file
  private func loadViewFromNib(xibFileName: String) -> UIView? {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: xibFileName, bundle: bundle)
    
    return nib.instantiateWithOwner(self, options: nil)[0] as? UIView
  }
  
  /// Loads view from xib file and setups
  private func setupXibView(xibFileName: String){
    let loadedView = loadViewFromNib(xibFileName)
    
    if let view = loadedView{
      view.frame = bounds
      view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      self.addSubview(view);
    }else {
      fatalError("Xib file was not found! Don't forget to override xibFileName property!")
    }
  }
  
}