//
//  MessageViewController.swift
//  iCare
//
//  Created by Rowin Shahi on 2/18/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: IB Action
  @IBAction func didTapView(_ sender: Any) {
    navigationController?.present(Storyboard.chat.initWithNavigationController(), animated: true, completion: nil)
  }
}
