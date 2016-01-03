//
//  DirectoryUtils.swift
//  SwiftWeather
//
//  Created by Brolis on 1/3/16.
//  Copyright © 2016 Brolis. All rights reserved.
//

import Foundation


class DicectoryUtils {
  
  static func documentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentDirectory = paths[0] as String
    return documentDirectory
  }
  
  static func pathFor(fileName fileName: String) -> String {
    return  DicectoryUtils.documentsDirectory().stringByAppendingPathComponent(fileName)
  }
  
  static func removeFile(fileName: String) -> Void{
    do{
      try NSFileManager.defaultManager().removeItemAtPath(DicectoryUtils.pathFor(fileName: fileName))
    }
    catch {
      
    }
  }
  
}
