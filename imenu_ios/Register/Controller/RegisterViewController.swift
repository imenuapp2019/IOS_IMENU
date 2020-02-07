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

class RegisterViewController: BaseViewController {

    var validNewUser:User?
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
        self.formValidation()
    }
    
    @IBAction func backToLoginBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsConfig()
        imageViewConfig()
        confirmButtonConfig()
        imageViewTableBackground.image = #imageLiteral(resourceName: "Background")
        roundedFrameView.layer.cornerRadius = 15
        self.shadowView(View: roundedFrameView)
    }
    
    
    private func imageViewConfig () {
        registerAvatarImageView.layer.borderWidth = 2.5
        registerAvatarImageView.layer.masksToBounds = false
        registerAvatarImageView.layer.borderColor = UIColor.lightGray.cgColor
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
            nameTextField.errorMessage = Literals.obligatoryField
        }
        else {
            nameTextField.errorMessage = Literals.empty
            nameIsNotEmpty = true
        }
        
        if lastname.isEmpty {
            lastNameTextField.errorMessage = Literals.obligatoryField
        }
        else {
            lastNameTextField.errorMessage = Literals.empty
            lastNameIsNotEmpty = true
        }
        
        if email.isEmpty {
            emailTextField.errorMessage = Literals.obligatoryField
        }
        else {
            emailIsNotEmpty = true
            if emailIsNotEmpty && emailValidation
                
            {
                emailTextField.errorMessage = Literals.empty
            }
        }
        
        if password.isEmpty {
            passwordTextField.errorMessage = Literals.obligatoryField
        }
        else {
            passwordTextField.errorMessage = Literals.empty
            passwordIsNotEmpty = true
        }
        
        if vrfPassword.isEmpty {
            vrfPasswordTextField.errorMessage = Literals.obligatoryField
        }
        else {
            vrfPasswordTextField.errorMessage = Literals.empty
            vrfPasswordIsNotEmpty = true
        }
        
        if nameIsNotEmpty && lastNameIsNotEmpty && emailIsNotEmpty && passwordIsNotEmpty && vrfPasswordIsNotEmpty  {
            
            if (password.count >= 8)   {
                if (vrfPassword.count >= 8){
                    if password != vrfPassword
                    {
                        passwordTextField.errorMessage = Literals.passwordNotMaching
                        vrfPasswordTextField.errorMessage = Literals.passwordNotMaching
                    }
                    else{
                        validNewUser = User (name: name, lastName: lastname, email: email, password: password, avatarID: avatarChosen)
                        passwordTextField.errorMessage = ""
                        let apiManger = APIManager ()
                        apiManger.postRegister(user: validNewUser!, completion: {result in
                            print(result!)
                            guard let validRegister = result, validRegister == true else {
                                return}
                            self.performSegue(withIdentifier: "segueHomeScreen", sender: nil)
                        })
                    }
                }
                
                else
                {
                    vrfPasswordTextField.errorMessage = Literals.minimumCharacters
                }
            }
                
            else
            {
                passwordTextField.errorMessage = Literals.minimumCharacters
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
    
    @objc func textFieldDidChange(_ emailTextField: UITextField) {
        
        if let floatingLabelTextField = emailTextField as? SkyFloatingLabelTextField {
            emailValidation = validateEmail(YourEMailAddress: emailTextField.text!)
            if( emailValidation ||  emailTextField.text!.count == 0) {
                
                floatingLabelTextField.errorMessage = ""
            }
            else {
                floatingLabelTextField.errorMessage = Literals.emailWrong
            }
        }
        
    }
    
    func shadowView(View view:UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
    }
}
