//
//  AvatarViewController.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 20/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var images:[UIImage] = [#imageLiteral(resourceName: "Capa 6"),#imageLiteral(resourceName: "Capa 5"),#imageLiteral(resourceName: "Capa 4"),#imageLiteral(resourceName: "Capa 3"),#imageLiteral(resourceName: "Capa 2"),#imageLiteral(resourceName: "Capa 7")]
    var avatarClicked:Int = 1
    
    @IBOutlet weak var avatarViewLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        popUpView.layer.borderColor = UIColor.black.cgColor
        popUpView.layer.borderWidth = 1
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        avatarViewLabel.backgroundColor = Color.greenBtnColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AvatarCollectionViewCell
        
        cell.avatarImageView.image = images[indexPath.row]
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
        
        return cell
    }
    
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
            avatarClicked = indexPath!.row
            changeAvatarImageView()
        
      }
    
    func changeAvatarImageView() {
        print  ("hey")
       if let presenter = presentingViewController as? RegisterViewController {
        presenter.registerAvatarImageView.image = images [avatarClicked]
                                       presenter.avatarChosen = avatarClicked + 1
                  print ("Hola register")
        print (presenter)
       }

       else  if let presenter = presentingViewController as? ProfileViewController {
        
            presenter.thisImage.image = images [avatarClicked]
        presenter.avatarChosenInProfile = avatarClicked + 1
        print ("Hola profile")
             
             }


                  
          
        dismiss(animated: true, completion: nil)
}
    
    
    
}
