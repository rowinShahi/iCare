//
//  Auditor.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation

protocol Auditor {
  func validateValue(_ value: String) -> String
}

/*
 1- Prevent any kind of phone number sharing with the following format +CCAABBBBBBB (Min and max length of 11 digits with prefix of “+”)
 */

struct PhoneNumberAuditor: Auditor {
  func validateValue(_ value: String) -> String {
    var result = value
    for i in value.characters.indices[value.startIndex..<value.endIndex]{
      if value[i] == "+"{
        let subString = value[i..<value.endIndex]
        if subString.characters.count >= 12{
          var phoneNoString = value[i..<value.index(i, offsetBy: 12)]
          phoneNoString.remove(at: phoneNoString.startIndex)
          if let _ = Int(phoneNoString){
            result = result.replacingOccurrences(of: "+" + phoneNoString, with: "************")
          }
        }
      }
    }
    return result
  }
}

/*
 2- URL in the chat message with the title of the page.
    Any URL except carlist.my should be redacted.
 */
struct WebAddressAuditor: Auditor {
  
  func validateValue(_ value: String) -> String {
    var result = value
    let urls = value.extractURLs()
    for url in urls{
      if url.absoluteString?.range(of:"carlist.my") == nil{
         result = result.replacingOccurrences(of: url.absoluteString!, with: "**********")
      }
    }
    return result
  }
}

/*
 3- Restricted Words Auditor
 */
struct BannedWordAuditor: Auditor {
  func validateValue(_ value: String) -> String {
    var result = value
    let words = value.components(separatedBy: " ")
    for word in words{
      for bannedWord in bannedWords{
        if bannedWord.lowercased() == word.lowercased(){
          result = result.replacingOccurrences(of: word, with: "*..*")
        }
      }
    }
    return result
  }
}

struct CompositeAuditor: Auditor {
  
  private let auditors: [Auditor]
  
  init(auditors: Auditor...) {
    self.auditors = auditors
  }
  
  func validateValue(_ value: String) -> String {
    var result:String = value
    for audit in auditors {
      result = audit.validateValue(result)
    }
    return result
  }
}

// MARK: Auditor Configurator
struct AuditorConfigurator {
  
// Content Audit for chat message
  func messageAuditor() -> Auditor {
    return CompositeAuditor(auditors: PhoneNumberAuditor(), WebAddressAuditor(), BannedWordAuditor())
  }
}
