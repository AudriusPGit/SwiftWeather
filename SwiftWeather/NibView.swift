//
//  NibView.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import UIKit

/// Loaded view from xib file, requires override nibName property in sub-classes
class NibView : UIView{
  
  /// Returns xib file name, must be overridden in subclasses
  var xibFileName: String{
    fatalError("This property must be overridden")
  }
  
  /// Initialization
  required override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupXibViewFrom(xibFileName: xibFileName)
  }
  
  /// Initialization
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupXibViewFrom(xibFileName: xibFileName)
  }
  
  /// Loads view from xib file
  private func loadViewFrom(xibFileName fileName: String) -> UIView? {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: xibFileName, bundle: bundle)
    
    return nib.instantiateWithOwner(self, options: nil)[0] as? UIView
  }
  
  /// Loads view from xib file and setups
  private func setupXibViewFrom(xibFileName fileName: String){
    let loadedView = loadViewFrom(xibFileName: fileName)
    
    if let view = loadedView{
      view.frame = bounds
      view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      self.addSubview(view);
    }else {
      fatalError("Xib file was not found! Don't forget to override xibFileName property!")
    }
  }
  
}