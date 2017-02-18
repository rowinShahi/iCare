//
//  Storyboard.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import Foundation

enum Storyboard: String, StoryboardProvider {
  
  case host, news, chat, more, message
  
  // MARK: Return Storyboard Identifier
  var storyboardIdentifier: String {
    get {
      switch self{
      case .host:
        return "HostTabBar"
      case .news:
        return "News"
      case .chat, .message:
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
      case .message:
        return "MessageViewController"
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
      case .message:
        return "MessageNavigationController"
      }
    }
  }
}
