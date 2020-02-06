//
//  ProfileViewController.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 04/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
 
    var avatarChosenInProfile:Int = 1

    @IBOutlet weak var parentView2: UIView!
    
    
    @IBOutlet weak var cardViewRounded: UIView!
    
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var cardViewShadow: UIView!
    @IBOutlet weak var saveBtn: RoundButton!
    @IBOutlet weak var thisImage: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var likeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewRounded()
        saveBtnConf()
        cardConfig()
    }
    

    func imageViewRounded (){
        
        
        deleteView.layer.cornerRadius = deleteView.frame.height/2
        thisImage.layer.borderWidth = 1
        thisImage.layer.masksToBounds = false
        thisImage.layer.borderColor = UIColor.black.cgColor
        thisImage.layer.cornerRadius = thisImage.frame.height/2
        thisImage.clipsToBounds = true
        
        }
    func saveBtnConf () {
               saveBtn.tintColor = Color.whiteColor
               saveBtn.backgroundColor = Color.greenBtnColor
               saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func cardConfig (){
                                //Shape
       // parentView2.bringSubviewToFront(cardViewShadow)
        cardViewRounded.layer.cornerRadius = 15
        cardViewShadow.layer.shadowColor = UIColor.black.cgColor
        cardViewShadow.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardViewShadow.layer.shadowRadius = 7.0
        cardViewShadow.layer.shadowOpacity = 0.5
       cardViewRounded.layer.masksToBounds = true
    }
    
    func deleteAccount () {
        
        
        
    }
    
}
