//
//  Auth.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class Auth: NSObject {
  static let shared: Auth = Auth()
  var currentUser:User?
}
