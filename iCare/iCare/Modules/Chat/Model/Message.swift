//
//  Message.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class Message: NSObject {
  
  var fromId: String?
  var text: String?
  var timestamp: NSNumber?
  var toId: String?
  
  init(dictionary: [String: AnyObject]) {
    super.init()
    fromId = dictionary["fromId"] as? String
    
    let message = dictionary["text"] as? String ?? ""
    let auditConfigurator = AuditorConfigurator()
    let messageValidator = auditConfigurator.messageAuditor()
    
    text = messageValidator.validateValue(message)
    timestamp = dictionary["timestamp"] as? NSNumber
    toId = dictionary["toId"] as? String
  }
}
