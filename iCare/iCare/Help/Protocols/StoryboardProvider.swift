//
//  StoryboardProvider.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit
protocol StoryboardProvider {
  var storyboardIdentifier: String { get }
  var viewControllerIdentifier: String { get }
  var navigationIdentifier: String { get }
}

extension StoryboardProvider  {
  
  func initWithNavigationController() -> UINavigationController{
    return  UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: self.navigationIdentifier) as! UINavigationController
  }
  
  func initWithViewController() -> UIViewController{
    return  UIStoryboard(name: self.storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: self.viewControllerIdentifier)
  }
}
