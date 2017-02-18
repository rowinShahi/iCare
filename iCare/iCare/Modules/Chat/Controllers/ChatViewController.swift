//
//  ChatViewController.swift
//  iCare
//
//  Created by Rowin Shahi on 2/17/17.
//  Copyright © 2017 Rowin. All rights reserved.
//

import UIKit

class ChatViewController: UICollectionViewController {
  
  // MARK: Properties
  // Cell Identifier for left right bubbles
  let leftCellId = "leftCellId"
  let rightCellId = "rightCellId"
  
  // Constraint for textView
  var containerViewBottomAnchor: NSLayoutConstraint?
  
  lazy var inputContainerView: ChatInputContainerView = {
    let chatInputContainerView = ChatInputContainerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    chatInputContainerView.chatLogController = self
    return chatInputContainerView
  }()
  
  // Dataholder for list
  var messages:[Message] = [] {
    didSet{
      collectionView?.reloadData()
      let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
  }
  
  @IBAction func didTapClose(_ sender: Any) {
    navigationController?.dismiss(animated: true, completion: nil)
  }
  
}

// MARK: View Life Cycle
extension ChatViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupKeyboardObservers()
    loadMessages()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return inputContainerView
    }
  }
  
  override var canBecomeFirstResponder : Bool {
    return true
  }
}

// MARK: Helper Methods
extension ChatViewController {
  
  // load messages from locally
  func loadMessages() {
    let response = Utils.readJson(fileName: "messages")
    
    guard let list = response as? [[String: AnyObject]] else {
      return
    }
    self.messages = list.map({ Message(dictionary: $0)})
  }
  
  // Action handler when send button tapped
  func handleSend() {
    if inputContainerView.inputTextField.text!.characters.count > 0{
      let message = Message(dictionary:["text":inputContainerView.inputTextField.text! as AnyObject,
                                        "fromId":Auth.shared.currentUser?.id as AnyObject])
      messages.append(message)
      inputContainerView.inputTextField.text! = ""
    }
  }
  
  // set keyboard notification
  func setupKeyboardObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
  }
  
  // action handler when keyboard displayed
  func handleKeyboardDidShow() {
    if messages.count > 0 {
      let indexPath = IndexPath(item: messages.count - 1, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
  }
  
  
}

// MARK: Collectionview Delegate
extension ChatViewController : UICollectionViewDelegateFlowLayout {
  
  func setupCollectionView () {
    collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    collectionView?.alwaysBounceVertical = true
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: leftCellId)
    collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: rightCellId)
    collectionView?.keyboardDismissMode = .interactive
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let message = messages[indexPath.row]
    var cellIdentifier = leftCellId
    if message.fromId == Auth.shared.currentUser?.id {
      cellIdentifier = rightCellId
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ChatMessageCell
    cell.textView.text = message.text ?? ""
    cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.text ?? "").width + 32
    cell.textView.isHidden = false
    
    if message.fromId == Auth.shared.currentUser?.id {
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
    height = estimateFrameForText(message.text!).height + 20
    let width = UIScreen.main.bounds.width
    return CGSize(width: width, height: height)
  }
  
  // Estimate the cell height according to content
  fileprivate func estimateFrameForText(_ text: String) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
  }
}

