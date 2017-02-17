//
//  Storyboard.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation

enum Storyboard: String, StoryboardProvider {
  
  case host, news, chat, more
  
  // MARK: Return Storyboard Identifier
  var storyboardIdentifier: String {
    get {
      switch self{
      case .host:
        return "HostTabBar"
      case .news:
        return "News"
      case .chat:
        return "Chat"
      case .more:
        return "More"
      }
    }
  }
  
  // MARK: Return ViewController Identifier
  var viewControllerIdentifier: String {
    get {
      switch self{
      case .host:
        return "HostTabBar"
      case .news:
        return "NewsViewController"
      case .chat:
        return "ChatViewController"
      case .more:
        return "MoreViewController"
      }
    }
  }
  
  // MARK: Return NavigationController Identifier
  var navigationIdentifier: String {
    get {
      switch self{
      case .host:
        return "HostTabBar"
      case .news:
        return "NewsNavigationController"
      case .chat:
        return "ChatNavigationController"
      case .more:
        return "MoreNavigationController"
      }
    }
  }
}
