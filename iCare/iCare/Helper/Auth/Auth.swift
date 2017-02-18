//
//  Auth.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

// MARK: Logined user saved
class Auth: NSObject {
  static let shared: Auth = Auth()
  var currentUser:User?
}
