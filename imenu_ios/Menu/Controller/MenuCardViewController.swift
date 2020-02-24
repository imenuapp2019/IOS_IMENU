//
//  MenuCardViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 27/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class MenuCardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    let ARImagesArray = [#imageLiteral(resourceName: "HD_Pizza"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_tarta"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_Pizza")]
    @IBAction func dishClicked(_ sender: Any) {
        
    }
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var menuSectionsCollectionView: UICollectionView!
    
    @IBOutlet weak var ARCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSectionsCollectionView.delegate = self
        menuSectionsCollectionView.dataSource = self
        ARCollectionView.delegate = self
        ARCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "CollectionViewCell", bundle:nil)
        menuSectionsCollectionView.register(nibName, forCellWithReuseIdentifier: "section")
        
        let ARNib = UINib(nibName: "ARSliderCell", bundle:nil)
        
        ARCollectionView.register(ARNib, forCellWithReuseIdentifier: "ARCell")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == menuSectionsCollectionView {
           return 6
        }
        else {
            
            return ARImagesArray.count        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuSectionsCollectionView {
                collectionView.backgroundColor = .clear
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section", for: indexPath) as! MenuCollectionViewCell
                   cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
                   return  cell as UICollectionViewCell
            
        }
        else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ARCell", for: indexPath) as! ARCollectionViewCell
            cell.arDishesImageView.image = ARImagesArray [indexPath.row]
            
            return cell as UICollectionViewCell
        }
        
       
    }
    
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {
   performSegue(withIdentifier: "segueDish", sender: nil)
    }
    
    
    
    
    
    
    
    
    
}
