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
    
        
    }


    func setupLabelText(){
        labelUserName.placeholder = Literals.btnUserPlaceHolder
        labelUserName.title = Literals.btnUserPlaceHolder
    }

}
