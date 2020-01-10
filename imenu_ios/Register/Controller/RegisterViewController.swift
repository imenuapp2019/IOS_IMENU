//
//  Register.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 09/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {
    


    @IBOutlet weak var registerAvatarImageView: UIImageView!
    
 //IB outlets
    @IBOutlet weak var roundedFrameView: UIView!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var vrfPasswordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = hideKeyboard()
        view.addGestureRecognizer(tap)
        moveScreenWhenUseKeyboard()
        
        
        
        //Make the roundedFrameView's border circular
        roundedFrameView.layer.cornerRadius = 15
        
        
        //Make the imageview circular
        registerAvatarImageView.layer.borderWidth = 1
        registerAvatarImageView.layer.masksToBounds = false
        registerAvatarImageView.layer.borderColor = UIColor.black.cgColor
        registerAvatarImageView.layer.cornerRadius = registerAvatarImageView.frame.height/2
        registerAvatarImageView.clipsToBounds = true
    }
    
    
    override func viewDidLayoutSubviews() {
        
        nameTextField.placeholder = Literals.placedeHolderRegisterName
        nameTextField.title = Literals.placedeHolderRegisterName
        nameTextField.tintColor = Color.greenBtnColor
        nameTextField.lineColor = Color.greenBtnColor
        nameTextField.selectedLineColor = Color.greenBtnColor
        nameTextField.lineHeight = 2.0
        nameTextField.selectedLineHeight = 3.0
        
        
        lastNameTextField.placeholder = Literals.placedeHolderRegisterLastName
        lastNameTextField.title = Literals.placedeHolderRegisterLastName
        lastNameTextField.tintColor = Color.greenBtnColor
        lastNameTextField.lineColor = Color.greenBtnColor
        lastNameTextField.selectedLineColor = Color.greenBtnColor
        lastNameTextField.lineHeight = 2.0
        lastNameTextField.selectedLineHeight = 3.0
        
        
        emailTextField.placeholder = Literals.placedeHolderRegisterEmail
        emailTextField.title = Literals.placedeHolderRegisterEmail
        emailTextField.tintColor = Color.greenBtnColor
        emailTextField.lineColor = Color.greenBtnColor
        emailTextField.selectedLineColor = Color.greenBtnColor
        emailTextField.lineHeight = 2.0
        emailTextField.selectedLineHeight = 3.0
        
        
        passwordTextField.placeholder = Literals.placedeHolderRegisterPassword
        passwordTextField.title = Literals.placedeHolderRegisterPassword
        passwordTextField.tintColor = Color.greenBtnColor
        passwordTextField.lineColor = Color.greenBtnColor
        passwordTextField.selectedLineColor = Color.greenBtnColor
        passwordTextField.lineHeight = 2.0
        passwordTextField.selectedLineHeight = 3.0
        
        
        vrfPasswordTextField.placeholder = Literals.placedeHolderRegisterVrfPassword
        vrfPasswordTextField.title = Literals.placedeHolderRegisterVrfPassword
        vrfPasswordTextField.tintColor = Color.greenBtnColor
        vrfPasswordTextField.lineColor = Color.greenBtnColor
        vrfPasswordTextField.selectedLineColor = Color.greenBtnColor
        vrfPasswordTextField.lineHeight = 2.0
        vrfPasswordTextField.selectedLineHeight = 3.0
        
        
        
        confirmBtn.setTitle(Literals.ConfirmRegisterBtn, for: .normal)
        confirmBtn.tintColor = Color.whiteColor
        confirmBtn.backgroundColor = Color.greenBtnColor
        confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
       
        
    }

}

extension RegisterViewController {
   
  func moveScreenWhenUseKeyboard(){
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
   
  func hideKeyboard()->UITapGestureRecognizer{
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    return tap
  }
   
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
   
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      if self.view.frame.origin.y == 0 {
        self.view.frame.origin.y -= keyboardSize.height
      }
    }
  }
  @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }
}
