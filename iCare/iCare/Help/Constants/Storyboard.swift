//
//  Storyboard.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation

enum Storyboard: String, StoryboardProvider {
  
  case host, news, chat
  
  // MARK: Return Storyboard Identifier
  var storyboardIdentifier: String {
    get {
      switch self{
      case .host:
        return "News"
      case .news:
        return "Article"
      case .chat:
        return "Match"
      }
    }
  }
  
  // MARK: Return ViewController Identifier
  var viewControllerIdentifier: String {
    get {
      switch self{
      case .host:
        return "News"
      case .news:
        return "Article"
      case .chat:
        return "Match"
      }
    }
  }
  
  // MARK: Return NavigationController Identifier
  var navigationIdentifier: String {
    get {
      switch self{
      case .host:
        return "News"
      case .news:
        return "Article"
      case .chat:
        return "Match"
      }
    }
  }
}
