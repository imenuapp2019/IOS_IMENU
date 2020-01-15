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
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var labelUserName: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var labelUserPassword: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var btninvited:UIButton!
    @IBOutlet weak var btnRegistry:UIButton!
    @IBOutlet weak var btnRecovery:UIButton!
    @IBOutlet weak var btnContinue:UIButton!
    @IBOutlet weak var eyeSecurity: UIButton!
    
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        if labelUserName.text == Literals.empty && labelUserPassword.text == Literals.empty {
            labelUserName.errorMessage = Literals.emptyEmailLabel
            labelUserPassword.errorMessage = Literals.emptyPassLabel
        }else {
        if labelUserName.text == Literals.empty {
            labelUserName.errorMessage = Literals.emptyEmailLabel
            labelUserPassword.errorMessage = Literals.empty
        }
        else if labelUserPassword.text == Literals.empty {
            labelUserPassword.errorMessage = Literals.emptyPassLabel
            labelUserName.errorMessage = Literals.empty
        }else {
            labelUserName.errorMessage = Literals.empty
            labelUserPassword.errorMessage = Literals.empty
            print("Envio de datos")
            }
        }
    }
    
     @IBAction func btninvitedClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnRegistryClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func btnRecoveryClicked(_ sender: Any) {
        
    }
    
    @IBAction func eyeSecurityClicked (_ sender: Any) {
        if labelUserPassword.isSecureTextEntry {
            labelUserPassword.isSecureTextEntry = false
        }else{
            labelUserPassword.isSecureTextEntry = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = hideKeyboard()
        view.addGestureRecognizer(tap)
        moveScreenWhenUseKeyboard()
        labelUserPassword.delegate = self
        setupBtn()
        setupImage()
        setupLabel()
    }
    
    func setupLabel() {
        labelUserName.placeholder = Literals.labelUserPlaceholder
        labelUserName.title = Literals.labelUserTitle
        labelUserPassword.placeholder = Literals.labelPasswordPlaceholder
        labelUserPassword.title = Literals.labelPasswordTitle
        labelUserPassword.isSecureTextEntry = true
        labelUserPassword.addTarget(self, action: #selector(eyeSecutrityHidde(_:)), for: .editingChanged)
        labelUserName.errorColor = Color.redColor
        labelUserName.addTarget(self, action: #selector(textFieldDidChangeEmail(_:)), for: .editingChanged)
    }
    
    func setupBtn(){
        let btnAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: Literals.btnRecoveryTitle,
            attributes: btnAttributes)
        
        eyeSecurity.isHidden = true
        eyeSecurity.backgroundColor = .clear
        btninvited.setTitle(Literals.btnInvitedTitle, for: .normal)
        btnContinue.setTitle(Literals.btnContinueTitle, for: .normal)
        btnRegistry.setTitle(Literals.btnRegistryTitle, for: .normal)
        
        btninvited.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnContinue.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnContinue.backgroundColor = Color.greenBtnColor
        btnRecovery.tintColor = Color.grayBtnColor
        btnRegistry.tintColor = Color.grayBtnColor
        
        btnRecovery.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setupImage(){
        imageLogo.image = #imageLiteral(resourceName: "LogoImenu")
        imageBackground.image = #imageLiteral(resourceName: "Background")
        view.sendSubviewToBack(imageBackground)
    }
    
}

extension LoginViewController:UITextFieldDelegate{
    
    @objc func eyeSecutrityHidde(_ textField: UITextField) {
        if labelUserPassword.text != "" {
            eyeSecurity.isHidden = false
        }else{
            eyeSecurity.isHidden = true
        }
    }
    
    
    @objc func textFieldDidChangeEmail(_ textfield: UITextField) {
        let email = "@"
        let point = "."
        if let text = labelUserName.text {
            if let floatingLabelTextField = labelUserName {
                if(text.count < 3 || !text.contains(email) || !text.contains(point) ) {
                    floatingLabelTextField.errorMessage = Literals.msjErrorEmail
                }else {
                    floatingLabelTextField.errorMessage = Literals.empty
                }
                if ( text == Literals.empty){
                    floatingLabelTextField.errorMessage = Literals.empty
                }
            }
        }
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


