//
//  Observable.swift
//  SwiftWeather
//
//  Created by Brolis on 1/2/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation

/// Notifies observer then observable's value changes. Base on:
/// * http://rasic.info/bindings-generics-swift-and-mvvm/
/// * http://fuckingclosuresyntax.com/
/// * http://blog.scottlogic.com/2015/02/11/swift-kvo-alternatives.html
class Observable<T>{
  
  typealias Observer = T -> Void
  private var observer: Observer?
  
  var value: T {
    didSet{
      observer?(value)
    }
  }
  
  /// Binds observer
  func bindAndFire(observer : Observer?){
    self.observer = observer
    observer?(value)
  }
  
  /// Initialize with value
  init(_ v: T){
    value = v
  }
  
}