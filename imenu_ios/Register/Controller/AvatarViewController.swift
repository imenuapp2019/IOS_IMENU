//
//  AvatarViewController.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 20/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {

  
    @IBOutlet weak var popUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        

       
    }
}
