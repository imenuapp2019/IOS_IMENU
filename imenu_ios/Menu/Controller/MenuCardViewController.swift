//
//  MenuCardViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 27/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class MenuCardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBAction func dishClicked(_ sender: Any) {
        
    }
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var menuSectionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSectionsCollectionView.delegate = self
        menuSectionsCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "CollectionViewCell", bundle:nil)
        menuSectionsCollectionView.register(nibName, forCellWithReuseIdentifier: "section")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.backgroundColor = .clear
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "section", for: indexPath) as! MenuCollectionViewCell
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))

        return  cell as UICollectionViewCell
    }
    
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {
   performSegue(withIdentifier: "segueDish", sender: nil)
    }
    
    
    
    
    
    
    
    
    
}
