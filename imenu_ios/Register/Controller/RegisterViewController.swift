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
        
        nameTextField.placeholder = "Name"
        lastNameTextField.placeholder = "Last name"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        vrfPasswordTextField.placeholder = "Repetir contraseña"
        
    }

}
