//
//  HostViewController.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class HostViewController: UITabBarController {
  // MARK: Properties
}

// MARK: ViewLife Cycle
extension HostViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupTabControllers()
  }
}

// MARK: Helper Methods
extension HostViewController {
  func setupTabControllers () {
  
    let controllers =  [TabDataSource.news.controller,
                        TabDataSource.chat.controller,
                        TabDataSource.more.controller]
    
    self.viewControllers = controllers
  }
}

// MARK: DataSource for tabBarItem
enum TabDataSource {
  
  case news, chat, more
  
  var controller: UINavigationController {
    var controller:UINavigationController
    var tabBarItem:UITabBarItem
    switch self {
    case .news:
      tabBarItem =  TabDataSource.setTabBarWith(title: "News", image: UIImage(named: "news_feed_icon"))
      controller =  Storyboard.news.initWithNavigationController()
    case .chat:
      tabBarItem =  TabDataSource.setTabBarWith(title: "Chat", image: UIImage(named: "chat_icon"))
      controller =  Storyboard.chat.initWithNavigationController()
    case .more:
      tabBarItem =  TabDataSource.setTabBarWith(title: "More", image: UIImage(named: "more_icon"))
      controller =  Storyboard.more.initWithNavigationController()
    }
    controller.tabBarItem = tabBarItem
    return controller
  }
  
  static func setTabBarWith(title:String, image:UIImage?) -> UITabBarItem {
    return UITabBarItem(title: title, image: image, selectedImage: nil)
  }
}
