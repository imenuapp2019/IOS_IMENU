//
//  LoginViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 09/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var labelUserName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var labelUserPassword: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var btninvited:UIButton!
    @IBOutlet weak var btnRegistry:UIButton!
    @IBOutlet weak var btnRecovery:UIButton!
    @IBOutlet weak var btnContinue:UIButton!
    @IBOutlet weak var eyeSecurity: UIButton!
    
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        if labelUserName.text == Literals.empty && labelUserPassword.text == Literals.empty {
            labelUserName.errorMessage = Literals.emptyEmailLabel
            labelUserPassword.errorMessage = Literals.emptyPassLabel
        }else{
            if labelUserName.text == Literals.empty {
                labelUserName.errorMessage = Literals.emptyEmailLabel
                labelUserPassword.errorMessage = Literals.empty
            }else if labelUserPassword.text == Literals.empty {
                labelUserPassword.errorMessage = Literals.emptyPassLabel
                labelUserName.errorMessage = Literals.empty
            }else if labelUserPassword.text!.count <= 7 {
                labelUserPassword.errorMessage = Literals.labelPassworLogin8caracterer
                labelUserName.errorMessage = Literals.empty
            }else {
                labelUserName.errorMessage = Literals.empty
                labelUserPassword.errorMessage = Literals.empty
                let user = User(email: labelUserName.text, password: labelUserPassword.text);
                self.apiRequestLogin(User:user)
            }
        }
    }
    
    @IBAction func btninvitedClicked(_ sender: Any) {
        performSegue(withIdentifier: "segueHome", sender: nil)
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
        callActivateMoveKeyboard(MoveKeyboard: true)
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
        labelUserName.errorColor = MyColor.redColor
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
        btnContinue.backgroundColor = MyColor.greenBtnColor
        btnRecovery.tintColor = MyColor.grayBtnColor
        btnRegistry.tintColor = MyColor.grayBtnColor
        
        btnRecovery.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setupImage(){
        imageLogo.image = #imageLiteral(resourceName: "LogoImenu")
        imageBackground.image = #imageLiteral(resourceName: "Background")
        view.sendSubviewToBack(imageBackground)
    }
    
    func apiRequestLogin(User user:User){
        let apiManager = APIManager()
        apiManager.postLogin(user: user, completion: { result
            in
            if let code = result, code == 200 {
                self.performSegue(withIdentifier: "segueHome", sender: nil)
            }else{
                let popUp = PopUp()
                let errorLogin = result
                let messageError:String?
                if errorLogin == 404 {
                    messageError = Literals.emailWrong
                }
                else if errorLogin == 403 {
                    messageError = Literals.paswordWrong
                }else{
                    messageError = Literals.errorConect
                }
                let alert = popUp.initializade(Title: Literals.titlePopUpLoginRequestWrong, Message: messageError ?? "Sin conexion")
                let btnOkAction = popUp.okAction(TitleButton: Literals.titleBotonPopUps)
                alert.addAction(btnOkAction)
                self.present(alert, animated: true)
            }
        })
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
