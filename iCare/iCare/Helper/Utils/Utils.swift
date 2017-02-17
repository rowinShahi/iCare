//
//  Utils.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation
class Utils: NSObject {
  
  public class func removeUserDefaults() {
    let appDomain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: appDomain)
    UserDefaults.standard.synchronize()
  }
  
  class func readJson(fileName:String, fileExtension:String? = "json") -> AnyObject? {
    guard let fileUrl =  Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return nil }
    guard let jsonData =  try? Data(contentsOf: fileUrl) else { return nil }
    if let data:AnyObject = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject?{ return data }
    return nil
  }
  
  public class func dictionaryFromJsonFileName(_ fileName: String) -> NSDictionary? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      if let data = try? Data(contentsOf: url) {
        var json =  NSDictionary()
        do {
          json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! NSDictionary
          return json
        } catch {
          debugPrint("JSON error ----- \n \(error)")
        }
      }
    }
    return nil
  }
  
  public class func arrayFromJsonFileName(_ fileName: String) -> NSArray? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      if let data = try? Data(contentsOf: url) {
        var jsonArray =  NSArray()
        do {
          jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! NSArray
          return jsonArray
        } catch {
          debugPrint("JSON error ----- \n \(error)")
        }
      }
    }
    return nil
  }
  
  /**
   Returns : NSArray array
   - parameter fileName : File Name without file extension
   - parameter targetClass : Target Class - pass - self.dynamicType
   */
  public class func array(fromFile fileName: String, forTargetClass targetClass: AnyClass) -> NSArray? {
    let bundle = Bundle(for: targetClass.self)
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else { return nil }
    guard let data = try? Data(contentsOf: url) else { return nil }
    
    var array = NSArray()
    do {
      array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! NSArray
      return array
    } catch {
      debugPrint("JSON error ----- \n \(error)")
    }
    return nil
  }
  
  class func dataFromBundle(forResource fileName: String, ofType type: String = "json") -> Data {
    guard let path = Bundle.main.path(forResource: fileName, ofType: type) else { return Data() }
    let pathURL = URL(fileURLWithPath: path)
    var jsonData = Data()
    do {
      jsonData = try Data(contentsOf: pathURL, options: Data.ReadingOptions.mappedIfSafe)
    } catch let e {
      fatalError("Error while parsing file: \(e)")
    }
    return jsonData
  }
}
