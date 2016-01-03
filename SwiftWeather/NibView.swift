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
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupXibView(xibFileName)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupXibView(xibFileName)
  }
  
  private func loadViewFromNib(xibFileName: String) -> UIView? {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: xibFileName, bundle: bundle)
    
    return nib.instantiateWithOwner(self, options: nil)[0] as? UIView
  }
  
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