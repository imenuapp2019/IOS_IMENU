//
//  DetailDishViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class DetailDishViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
    
 

    @IBAction func detailBtnAction(_ sender: Any) {
        showDeatailView ()

    }
    
    @IBAction func alertBtnAction(_ sender: Any) {
      ShowAlergView()
    }

    @IBOutlet weak var alergView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var alerBtnView: UIView!
    @IBOutlet weak var detailBtnView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var images:[UIImage] = [#imageLiteral(resourceName: "HD_tarta"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_Pizza"),#imageLiteral(resourceName: "HDpollo"),#imageLiteral(resourceName: "HD_Pizza"),#imageLiteral(resourceName: "HD_tarta")]
    var liked:Bool = false
    @IBOutlet weak var likebtnView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var innerCard: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBAction func heartBtnAction(_ sender: Any) {
        changeDishLike ()
    }
    
    var currentIndex = 0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.title = "Detalle"
        collectionView.dataSource = self
        collectionView.delegate = self
        initialViewConfig ()
        
    }
    
    func startTimer () {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction) , userInfo: nil, repeats: true)
    }
    
    @objc func timerAction () {
        let desiredScrollPosition = (currentIndex < images.count - 1) ? currentIndex + 1 : 0
        collectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                 6
             }
             
       public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDish", for: indexPath) as! DishesSliderCollectionViewCell
        
        cell.dishesImageView.image = images [indexPath.item]
              return cell
             }
          
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentIndex
    }
    
    func changeDishLike () {
    
        if !liked {
            heartImageView.image = UIImage(named: "corazon_rojo")
            liked = true
        }
        else {
            heartImageView.image = UIImage(named: "corazon_gris")
            liked = false
        }
    }
    
    
    func showDeatailView () {
       
        detailTextView.isHidden = false
        alergView.isHidden = true
        detailBtnView.backgroundColor = UIColor.lightGray
        alerBtnView.backgroundColor = UIColor.white
    }
    
    func ShowAlergView () {
        alergView.isHidden = false
        detailTextView.isHidden = true
        alerBtnView.backgroundColor = UIColor.lightGray
         detailBtnView.backgroundColor = UIColor.white
        
    }
    func initialViewConfig () {
        
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        dishPriceLabel.layer.cornerRadius = 15
        dishPriceLabel.layer.masksToBounds = true
        innerCard.layer.cornerRadius = 15
        innerCard.layer.masksToBounds = true
        likebtnView.layer.cornerRadius = likebtnView.frame.height/2
        pageControl.numberOfPages = images.count
        startTimer()
        textView.isEditable = false
        detailBtnView.backgroundColor = UIColor.lightGray
         alergView.isHidden = true
        
    }
    
}
