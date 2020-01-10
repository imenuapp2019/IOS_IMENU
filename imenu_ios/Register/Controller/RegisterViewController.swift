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
    
    let greenColor:UIColor = UIColor(red: 38/255, green: 128/255, blue: 38/255, alpha: 1)
     let whiteColor:UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

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
        lastNameTextField.placeholder = Literals.placedeHolderRegisterLastName
        lastNameTextField.title = Literals.placedeHolderRegisterLastName
        emailTextField.placeholder = Literals.placedeHolderRegisterEmail
        emailTextField.title = Literals.placedeHolderRegisterEmail
        passwordTextField.placeholder = Literals.placedeHolderRegisterPassword
        passwordTextField.title = Literals.placedeHolderRegisterPassword
        vrfPasswordTextField.placeholder = Literals.placedeHolderRegisterVrfPassword
        vrfPasswordTextField.title = Literals.placedeHolderRegisterVrfPassword
        
        confirmBtn.setTitle(Literals.ConfirmRegisterBtn, for: .normal)
        confirmBtn.tintColor = whiteColor
        confirmBtn.backgroundColor = greenColor
        
        
    }

}
