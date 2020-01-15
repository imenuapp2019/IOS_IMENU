//
//  RecoverViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 13/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RecoverViewController: UIViewController {
    
    
    @IBOutlet weak var iconSendMail: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelTextRecoverEmail: UILabel!
    @IBOutlet weak var inputlabelEmail: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnRecover: RoundButton!
    
    
    @IBAction func iconBackClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = hideKeyboard()
        view.addGestureRecognizer(tap)
        moveScreenWhenUseKeyboard()
        setupBtn()
        setupImage()
        setupLabelAndInput()
    }
    
    func setupBtn(){
        btnRecover.setTitle(Literals.btnRecover, for: .normal)
        btnRecover.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnRecover.backgroundColor = Color.greenBtnColor
    }
    
    func setupLabelAndInput(){
        labelTextRecoverEmail.text = Literals.labelRecoverText
        inputlabelEmail.title = Literals.labelRecoverTittle
        inputlabelEmail.placeholder = Literals.labelRecoverPlaceHolder
        inputlabelEmail.errorColor = Color.redColor
        inputlabelEmail.addTarget(self, action: #selector(textFieldDidChangeEmail(_:)), for: .editingChanged)
    }
    
    func setupImage() {
        logoImage.image = #imageLiteral(resourceName: "LogoImenu")
        backgroundImage.image = #imageLiteral(resourceName: "BackgroundFull")
        backgroundImage.contentMode = .scaleAspectFill
        cardView.layer.cornerRadius = 15
        cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

extension RecoverViewController:UITextFieldDelegate{

    @objc func textFieldDidChangeEmail(_ textfield: UITextField) {
        let email = "@"
        let point = "."
        if let text = inputlabelEmail.text {
            if let floatingLabelTextField = inputlabelEmail {
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

extension RecoverViewController {
    
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




