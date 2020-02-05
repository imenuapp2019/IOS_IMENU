//
//  ProfileViewController.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 04/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class Profile_ViewController: UIViewController {
 
    var avatarChosenInProfile:Int = 1

 
    @IBOutlet weak var thisImage: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var likeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            imageViewRounded()
    }
    

    func imageViewRounded (){
        
        likeView.layer.cornerRadius = likeView.frame.height/2
        deleteView.layer.cornerRadius = deleteView.frame.height/2
        thisImage.layer.borderWidth = 1
        thisImage.layer.masksToBounds = false
        thisImage.layer.borderColor = UIColor.black.cgColor
        thisImage.layer.cornerRadius = thisImage.frame.height/2
        thisImage.clipsToBounds = true
        
        }
}
