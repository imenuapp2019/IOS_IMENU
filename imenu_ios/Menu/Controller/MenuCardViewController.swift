//
//  MenuCardViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 27/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class MenuCardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    var currentIndex = 0
    let ARImagesArray = [#imageLiteral(resourceName: "HD_Pizza"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_tarta")]
    let arrayOfMenuSectionsImages = [#imageLiteral(resourceName: "especiales_this"),#imageLiteral(resourceName: "segundos_this"),#imageLiteral(resourceName: "bebida_this"),#imageLiteral(resourceName: "postres_this"),#imageLiteral(resourceName: "entrantes_this"),#imageLiteral(resourceName: "primer_this")]
    var timer:Timer?
    @IBAction func dishClicked(_ sender: Any) {
        
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var menuSectionsCollectionView: UICollectionView!
    
    @IBOutlet weak var ARCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        pageControl.numberOfPages = ARImagesArray.count
        self.view.layer.cornerRadius = 30
        menuSectionsCollectionView.delegate = self
        menuSectionsCollectionView.dataSource = self
        ARCollectionView.delegate = self
        ARCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "CollectionViewCell", bundle:nil)
        menuSectionsCollectionView.register(nibName, forCellWithReuseIdentifier: "section")
        
        let ARNib = UINib(nibName: "ARSliderCell", bundle:nil)
        
        ARCollectionView.register(ARNib, forCellWithReuseIdentifier: "ARCell")
        
    }
    
    
    func startTimer () {
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(timerAction) , userInfo: nil, repeats: true)
    }
    
    @objc func timerAction () {
        let desiredScrollPosition = (currentIndex < ARImagesArray.count - 1) ? currentIndex + 1 : 0
        ARCollectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
        
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
            
            assignImageToSection(index: indexPath.row, image: cell.menuSectionImageView, name: cell.menuSectionLabel)
            
            
//                   cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
                   return  cell as UICollectionViewCell
            
        }
        else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ARCell", for: indexPath) as! ARCollectionViewCell
            cell.arDishesImageView.image = ARImagesArray [indexPath.row]
            
            return cell as UICollectionViewCell
        }
        
       
    }
    
    private func assignImageToSection (index:Int, image:UIImageView, name:UILabel) {
        
        switch index {
        case 0:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Entrantes"
        case 1:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Primeros platos"
        case 2:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Segundos Platos"
        case 3:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Postres"
        case 4:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Bebidas"
        case 5:
                image.image = arrayOfMenuSectionsImages[index]
                name.text = "Especiales"
        default:
            return
        }
    }
    
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {
   performSegue(withIdentifier: "segueDish", sender: nil)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == menuSectionsCollectionView {
            
        }
        else{
           
            currentIndex = Int(scrollView.contentOffset.x / ARCollectionView.frame.size.width)
                   pageControl.currentPage = currentIndex
            
        }
       
    }
 
}
