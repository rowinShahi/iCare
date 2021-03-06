//
//  ChatInputContainerView.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class ChatInputContainerView: UIView , UITextFieldDelegate {
  
  weak var chatLogController: ChatViewController? {
    didSet {
      sendButton.addTarget(chatLogController, action: #selector(ChatViewController.handleSend), for: .touchUpInside)
    }
  }
  
  lazy var inputTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter message..."
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.delegate = self
    return textField
  }()
  
  let sendButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    sendButton.setTitle("Send", for: UIControlState())
    sendButton.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(sendButton)
    //x,y,w,h
    sendButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    sendButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    
    addSubview(self.inputTextField)
    //x,y,w,h
    self.inputTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    self.inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
    self.inputTextField.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    
    let separatorLineView = UIView()
    separatorLineView.backgroundColor = UIColor.lightGray
    separatorLineView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(separatorLineView)
    
    //x,y,w,h
    separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    separatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    chatLogController?.handleSend()
    return true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

