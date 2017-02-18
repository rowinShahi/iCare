//
//  Utils.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation
class Utils: NSObject {
  class func readJson(fileName:String, fileExtension:String? = "json") -> AnyObject? {
    guard let fileUrl =  Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return nil }
    guard let jsonData =  try? Data(contentsOf: fileUrl) else { return nil }
    if let data:AnyObject = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject?{ return data }
    return nil
  }
}
