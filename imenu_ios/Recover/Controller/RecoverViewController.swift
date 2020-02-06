//
//  RecoverViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 13/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RecoverViewController: BaseViewController {
    
    
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelTextRecoverEmail: UILabel!
    @IBOutlet weak var inputlabelEmail: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var btnRecover: RoundButton!
    
    let popUp = PopUp()
    
    @IBAction func btnRecoverClick(_ sender: Any) {
        apiRequestRecover()
    }
    
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
        emailImage.image = #imageLiteral(resourceName: "iconRecover")
    }
    
    func apiRequestRecover(){
        let apiManger = APIManager ()
        if  let textInputEmail = inputlabelEmail.text, textInputEmail != ""{
            apiManger.postRecover(email: textInputEmail, completion: {
                result in
                guard let resutCode = result else { return }
                let alert = self.alertResponse(Result: resutCode, PopUp: self.popUp, TextInputEmail: textInputEmail)
                let btnOkAction = UIAlertAction(title: Literals.titleBotonPopUps, style: UIAlertAction.Style.default, handler: {
                    
                    action in if result == 200 { self.dismiss(animated: true, completion: nil )}
                })
                alert.addAction(btnOkAction)
                self.present(alert, animated: true)
            })
        }else{
            let alert = self.popUp.initializade(Title: Literals.titlePopUpLoginRequestWrong, Message: Literals.recoverTextEmpty)
            let btnOkAction = popUp.okAction(TitleButton: Literals.titleBotonPopUps)
            alert.addAction(btnOkAction)
            self.present(alert, animated: true)
        }
    }
    
    func alertResponse(Result result:Int,PopUp popUp:PopUp,TextInputEmail textInputEmail:String) -> UIAlertController {
        var alert:UIAlertController?
        switch result {
        case 200:
            alert = self.popUp.initializade(Title: Literals.messageRecover, Message: textInputEmail)
            break
        case 400:
            alert = self.popUp.initializade(Title: Literals.emailHaventBBDD, Message: textInputEmail)
            break
        case 600:
            alert = self.popUp.initializade(Title: Literals.errorConect, Message: "")
            break
        default:
            break
        }
        return alert!
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
