//
//  customTextField.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 22/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//
import UIKit

class View: UIView {

  private var usernameLabelYAnchorConstraint: NSLayoutConstraint!
  private var usernameLabelLeadingAnchor: NSLayoutConstraint!

  private lazy var usernameLBL: UILabel! = {
    let label = UILabel()
    label.text = "Username"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.alpha = 0.5
    return label
  }()

  private lazy var usernameTextField: UITextField! = {
    let textLabel = UITextField()
    textLabel.borderStyle = .roundedRect
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    return textLabel
  }()

  init() {
    super.init(frame: UIScreen.main.bounds)
    addSubview(usernameTextField)
    addSubview(usernameLBL)
    backgroundColor = UIColor(white: 1, alpha: 1)
    usernameTextField.delegate = self

    configureViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureViews() {
    let margins = self.layoutMarginsGuide
    usernameLabelYAnchorConstraint = usernameLBL.centerYAnchor.constraint(equalTo: usernameTextField.centerYAnchor, constant: 0)
    usernameLabelLeadingAnchor = usernameLBL.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor, constant: 5)

    NSLayoutConstraint.activate([
      usernameTextField.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
      usernameTextField.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
      usernameTextField.widthAnchor.constraint(equalToConstant: 100),
      usernameTextField.heightAnchor.constraint(equalToConstant: 25),

      usernameLabelYAnchorConstraint,
      usernameLabelLeadingAnchor,
      ])
  }

}

extension View: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return textField.resignFirstResponder()
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    usernameLabelYAnchorConstraint.constant = -25
    usernameLabelLeadingAnchor.constant = 0
    performAnimation(transform: CGAffineTransform(scaleX: 0.8, y: 0.8))
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty {
      usernameLabelYAnchorConstraint.constant = 0
      usernameLabelLeadingAnchor.constant = 5
      performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
    }
  }

  fileprivate func performAnimation(transform: CGAffineTransform) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.usernameLBL.transform = transform
      self.layoutIfNeeded()
    }, completion: nil)
  }

}
