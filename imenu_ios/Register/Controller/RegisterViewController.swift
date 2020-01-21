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
    var avatarChosen:Int = 1
    
    @IBOutlet weak var imageViewTableBackground: UIImageView!
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
    
  
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsConfig() //Confifure all the textfields.
        imageViewConfig() //Make the imageview circular
        confirmButtonConfig()
        imageViewTableBackground.image = #imageLiteral(resourceName: "Background")
        
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
            
            if (password.count >= 8)   {
                if (vrfPassword.count >= 8){
                    if password != vrfPassword
                        {
                            passwordTextField.errorMessage = "Contraseñas no coincidente"
                            vrfPasswordTextField.errorMessage = "Contraseñas no coincidente"
                        }
                   
                    else    {
                                validNewUser = User (name: name, lastname: lastname, email: email, password: password, avatar: avatarChosen)
                                passwordTextField.errorMessage = ""
                                let apiManger = APIManager ()
                                apiManger.postAlamofire(user: validNewUser!)
                            }
                        }
                    
                else
                    {
                         vrfPasswordTextField.errorMessage = "Mínimo ocho caracteres"
                    }
            }
        
        else
            {
                passwordTextField.errorMessage = "Mínimo ocho caracteres"
            }
        }
    }
    
    
    private func textFieldBasicConfiguration (textfield:SkyFloatingLabelTextField?, name:String)->SkyFloatingLabelTextField?{
        
            let textfield:SkyFloatingLabelTextField? = textfield
            textfield!.tintColor = Color.greenBtnColor
            textfield!.lineColor = Color.greenBtnColor
            textfield!.selectedLineColor = Color.greenBtnColor
            textfield!.lineHeight = 2.0
            textfield!.selectedLineHeight = 3.0
            textfield!.placeholder = name
            textfield!.title = name
        
        return textfield
    }
        
    private func textFieldsConfig () {
        
        nameTextField = textFieldBasicConfiguration(textfield: nameTextField, name: Literals.placedeHolderRegisterName)
       
        lastNameTextField = textFieldBasicConfiguration(textfield: lastNameTextField, name: Literals.placedeHolderRegisterLastName)
        
        emailTextField = textFieldBasicConfiguration(textfield: emailTextField, name: Literals.placedeHolderRegisterEmail)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        passwordTextField = textFieldBasicConfiguration(textfield: passwordTextField, name: Literals.placedeHolderRegisterPassword)
        passwordTextField.isSecureTextEntry = true
        
        
        vrfPasswordTextField = textFieldBasicConfiguration(textfield: vrfPasswordTextField, name: Literals.placedeHolderRegisterVrfPassword)
        vrfPasswordTextField.isSecureTextEntry = true
    }
    
    private func confirmButtonConfig (){
        
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

