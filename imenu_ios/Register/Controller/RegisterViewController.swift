//
//  Register.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 09/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class RegisterViewController: UIViewController {
    

                    //IB outlets
    var validNewUser:User?
    let urlToPost = URL(string:"http://localhost:8888/back_imenu-develop/public/api/register")
    var emailValidation:Bool = false
    
    @IBOutlet weak var registerAvatarImageView: UIImageView!
    @IBOutlet weak var roundedFrameView: UIView!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var avatarSelectionView: UIView!
    
    @IBOutlet weak var vrfPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBAction func confirmBtnAction(_ sender: Any) {
    
        formValidation()
        
    }
    
    @IBAction func backToLoginBtn(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectAvatarBtn(_ sender: Any) {
        if avatarSelectionView.isHidden
        {
         avatarSelectionView.isHidden = false
        }
        else
        {
         avatarSelectionView.isHidden = true
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarSelectionView.isHidden = true
        textFieldConfig() //Confifure all the textfields.
        imageViewConfig() //Make the imageview circular
        
        let tap = hideKeyboard()
        view.addGestureRecognizer(tap)
        moveScreenWhenUseKeyboard()
        
        //Make the roundedFrameView's border circular
        roundedFrameView.layer.cornerRadius = 15
    }
    
    private func imageViewConfig () {
       
               registerAvatarImageView.layer.borderWidth = 1
               registerAvatarImageView.layer.masksToBounds = false
               registerAvatarImageView.layer.borderColor = UIColor.black.cgColor
               registerAvatarImageView.layer.cornerRadius = registerAvatarImageView.frame.height/2
               registerAvatarImageView.clipsToBounds = true
    }
    
    private func formValidation () {
        let name = nameTextField.text!
        let lastname = lastNameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let vrfPassword = vrfPasswordTextField.text!
        var nameIsNotEmpty:Bool = false
        var lastNameIsNotEmpty:Bool = false
        var emailIsNotEmpty:Bool = false
        var passwordIsNotEmpty:Bool = false
        var vrfPasswordIsNotEmpty:Bool = false
        
        
        if name.isEmpty {
                nameTextField.errorMessage = "Campo obligatorio"
        }
        else {
            nameTextField.errorMessage = ""
            nameIsNotEmpty = true
        }

        if lastname.isEmpty {
               
                lastNameTextField.errorMessage = "Campo obligatorio"
            }
        else {
                lastNameTextField.errorMessage = ""
                lastNameIsNotEmpty = true
            }
        
        if email.isEmpty {
                emailTextField.errorMessage = "Campo obligatorio"
            }
        else {
                
                emailIsNotEmpty = true
                if emailIsNotEmpty && emailValidation
                
                {
                   emailTextField.errorMessage = ""
                }
            }
        
        if password.isEmpty {
                passwordTextField.errorMessage = "Campo obligatorio"
            }
        else {
            passwordTextField.errorMessage = ""
            passwordIsNotEmpty = true
        }
        
        if vrfPassword.isEmpty {
                vrfPasswordTextField.errorMessage = "Repita su contraseña "
            }
        else {
            vrfPasswordTextField.errorMessage = ""
            vrfPasswordIsNotEmpty = true
        }
        
        
        
        if nameIsNotEmpty && lastNameIsNotEmpty && emailIsNotEmpty && passwordIsNotEmpty && vrfPasswordIsNotEmpty  {
            print (password.count)
            if password.count >= 8 {
           
                if password != vrfPassword
                {
                    passwordTextField.errorMessage = "Contraseñas no coincidente"
                }
                else {
                    validNewUser = User (name: name, lastname: lastname, email: email, password: password, avatar: 1)
                       passwordTextField.errorMessage = ""
                     let apiManger = APIManager ()
                    apiManger.postAlamofire(user: validNewUser!)
                    //postAlamofire(user: validNewUser!)
                    }
                }

            else {
                
                passwordTextField.errorMessage = "Mínimo ocho caracteres"
               
                    }
        }
    }
        
    private func textFieldConfig () {

         nameTextField.placeholder = Literals.placedeHolderRegisterName
         nameTextField.title = Literals.placedeHolderRegisterName
         nameTextField.tintColor = Color.greenBtnColor
         nameTextField.lineColor = Color.greenBtnColor
         nameTextField.selectedLineColor = Color.greenBtnColor
         nameTextField.lineHeight = 2.0
         nameTextField.selectedLineHeight = 3.0
         nameTextField.errorColor = Color.redColor
         
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
         emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
         passwordTextField.placeholder = Literals.placedeHolderRegisterPassword
         passwordTextField.title = Literals.placedeHolderRegisterPassword
         passwordTextField.tintColor = Color.greenBtnColor
         passwordTextField.lineColor = Color.greenBtnColor
         passwordTextField.selectedLineColor = Color.greenBtnColor
         passwordTextField.lineHeight = 2.0
         passwordTextField.selectedLineHeight = 3.0
        passwordTextField.isSecureTextEntry = true
         
         vrfPasswordTextField.placeholder = Literals.placedeHolderRegisterVrfPassword
         vrfPasswordTextField.title = Literals.placedeHolderRegisterVrfPassword
         vrfPasswordTextField.tintColor = Color.greenBtnColor
         vrfPasswordTextField.lineColor = Color.greenBtnColor
         vrfPasswordTextField.selectedLineColor = Color.greenBtnColor
         vrfPasswordTextField.lineHeight = 2.0
         vrfPasswordTextField.selectedLineHeight = 3.0
        vrfPasswordTextField.isSecureTextEntry = true
         
         confirmBtn.setTitle(Literals.ConfirmRegisterBtn, for: .normal)
         confirmBtn.tintColor = Color.whiteColor
         confirmBtn.backgroundColor = Color.greenBtnColor
         confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    
    
   
    
    func validateEmail(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    

    //email texfield's validation (editing listener).
    @objc func textFieldDidChange(_ emailTextField: UITextField) {
           
                if let floatingLabelTextField = emailTextField as? SkyFloatingLabelTextField {
                    emailValidation = validateEmail(YourEMailAddress: emailTextField.text!)
                    if( emailValidation ||  emailTextField.text!.count == 0) {
                       
                         floatingLabelTextField.errorMessage = ""
                    }
                    else {
                        // The error message will only disappear when we reset it to nil or empty string
                        
                             floatingLabelTextField.errorMessage = "Invalid email"
                       
                    }
                }
            }
        }
    

                                //Extensions

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

