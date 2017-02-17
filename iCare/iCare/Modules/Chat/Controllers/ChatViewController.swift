//
//  ChatViewController.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class ChatViewController: UICollectionViewController, UINavigationControllerDelegate {
  
  // MARK: Properties
  let cellId = "cellId"
  var containerViewBottomAnchor: NSLayoutConstraint?
  
  lazy var inputContainerView: ChatInputContainerView = {
    let chatInputContainerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    chatInputContainerView.chatLogController = self
    return chatInputContainerView
  }()
  
  var messages:[String] = ["Perfect, I am really glad to hear that! How may I help you today?",
                           "I am really sorry to hear that. Is there anything I can do to help you?",
                           "Hello! May I have your name pleas?",
                           "Tell me more about…",
                           "So you are saying that…correct",
                           "I’m not sure, but let me find out for you.",
                           "I’m sorry to keep you waiting. I have managed to reproduce the problem. Here’s what needs to be done to fix it.",
                           "Can I put you on hold for a moment?",
                           "So you are saying that…correct",
                           "I’m sorry this has happened. I understand your frustration, and I will do my best to help you.",
                           "Let me put you on hold for just a few moments and verify this information.",
                           "Jerry, let me review your transaction history. Please bear with me for a few more minutes.",
                           "Hello! May I have your name pleas?",
                           "Tell me more about…",
                           "So you are saying that…correct",
                           "I’m sorry this has happened. I understand your frustration, and I will do my best to help you.",
                           "Let me put you on hold for just a few moments and verify this information.",
                           "Jerry, let me review your transaction history. Please bear with me for a few more minutes.",
                           "So you are saying that…correct",
                           "I’m not sure, but let me find out for you.",
                           "I’m sorry to keep you waiting. I have managed to reproduce the problem. Here’s what needs to be done to fix it."]
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupKeyboardObservers()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  func handleSend() {
    if inputContainerView.inputTextField.text!.characters.count > 0{
      messages.append(inputContainerView.inputTextField.text!)
      collectionView?.reloadData()
      let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return inputContainerView
    }
  }
  
  override var canBecomeFirstResponder : Bool {
    return true
  }
  
  func setupKeyboardObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
  }
  
  func handleKeyboardDidShow() {
    if messages.count > 0 {
      let indexPath = IndexPath(item: messages.count - 1, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
  }
}

extension ChatViewController : UICollectionViewDelegateFlowLayout {
  
  func setupCollectionView () {
    collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    collectionView?.alwaysBounceVertical = true
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.keyboardDismissMode = .interactive
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell

    let message = messages[indexPath.row]
    
    cell.textView.text = message
    cell.bubbleWidthAnchor?.constant = estimateFrameForText(message).width + 32
    cell.textView.isHidden = false
    
    if message.characters.count%2 == 0 {
      cell.bubbleView.backgroundColor = ChatMessageCell.blueColor
      cell.textView.textColor = UIColor.white
      cell.bubbleViewRightAnchor?.isActive = true
      cell.bubbleViewLeftAnchor?.isActive = false
    }else{
      cell.bubbleView.backgroundColor = UIColor.lightGray
      cell.textView.textColor = UIColor.black
      cell.bubbleViewRightAnchor?.isActive = false
      cell.bubbleViewLeftAnchor?.isActive = true
      
    }
    
    return cell
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    collectionView?.collectionViewLayout.invalidateLayout()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let message = messages[indexPath.row]
    var height: CGFloat = 80
    height = estimateFrameForText(message).height + 20
    let width = UIScreen.main.bounds.width
    return CGSize(width: width, height: height)
  }
  
  fileprivate func estimateFrameForText(_ text: String) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
  }
}

