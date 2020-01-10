//
//  LoginViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 09/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    

    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var labelUserName: SkyFloatingLabelTextFieldWithIcon!

    @IBOutlet weak var labelUserPassword: SkyFloatingLabelTextFieldWithIcon!
    
    @IBAction func btninvited(_ sender: Any) {
    
    }
    
    @IBAction func btnRegistry(_ sender: Any) {
    
    }
    
    
    @IBAction func btnRecovery(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = hideKeyboard()
        view.addGestureRecognizer(tap)
        moveScreenWhenUseKeyboard()
        
        setupTextField()
    }
    
    func setupTextField() {
        labelUserName.placeholder = Literals.labelUserPlaceholder
        labelUserName.title = Literals.labelUserTitle
        labelUserPassword.placeholder = Literals.labelPasswordPlaceholder
        labelUserPassword.title = Literals.labelPasswordTitle
    }
}

extension LoginViewController {
    
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


