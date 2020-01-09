//
//  LoginViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 09/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var labelUserName: UITextField!
    @IBOutlet weak var labelUserPassword: UITextField!
    
    
    @IBAction func btninvited(_ sender: Any) {
    
    }
    
    @IBAction func btnRegistry(_ sender: Any) {
    
    }
    
    
    @IBAction func btnRecovery(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        labelUserName.text = ""
    }


}
