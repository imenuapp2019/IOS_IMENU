//
//  MenuCardViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 27/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

//protocol CellClickedDelegate {
//    func passInfoToDish (numer:Int)
//
//}

class MenuCardViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
  
    
    @IBOutlet var MainCard: UIView!
    @IBOutlet weak var ARBtn: UIButton!
    //  var  cellWasClickDelegate: CellClickedDelegate!
    
    var currentIndex = 0
    let ARImagesArray = [#imageLiteral(resourceName: "HD_Pizza"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_tarta")]
    let arrayOfMenuSectionsImages = [#imageLiteral(resourceName: "especiales_this"),#imageLiteral(resourceName: "segundos_this"),#imageLiteral(resourceName: "entrantes_this"),#imageLiteral(resourceName: "postres_this"),#imageLiteral(resourceName: "bebida_this"),#imageLiteral(resourceName: "primer_this")]
    var timer:Timer?
    var menuViewController:MenuViewController?
    @IBAction func dishClicked(_ sender: Any) {
        
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var handleArea: UIView!
   
    
    @IBOutlet weak var ARCollectionView: UICollectionView!
     @IBOutlet weak var menuSectionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController = MenuViewController ()
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
    override func viewDidAppear(_ animated: Bool) {
       // view.frame.origin.y = view.frame.height - view.frame.height * 0.13
        
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
            
            
                   cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
            
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
   
        let location = sender.location(in: self.menuSectionsCollectionView)
              let indexPath = self.menuSectionsCollectionView.indexPathForItem(at: location)
             let cellClickedIndex = indexPath!.row
        menuViewController?.clickedOnSectionBool = true
        let storyboard = UIStoryboard(name: "Dish", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "dish") as! DishViewController
        controller.menuSection = cellClickedIndex
        self.present(controller, animated: true, completion: nil)
    
        
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
