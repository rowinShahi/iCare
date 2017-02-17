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
    view.backgroundColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupTabControllers()
  }
}

// MARK: Helper Methods
extension HostViewController {
  func setupTabControllers () {
    tabBar.tintColor = .blue
  }
  
  // config tabBar
  func setTabBarWith(title:String, imageNamed:String) -> UITabBarItem {
    return UITabBarItem(title: title, image: UIImage(named: imageNamed), selectedImage: nil)
  }
}
