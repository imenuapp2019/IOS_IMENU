//
//  DetailDishViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class DetailDishViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView!
    var images:[UIImage] = [#imageLiteral(resourceName: "Capa 6"),#imageLiteral(resourceName: "Capa 5"),#imageLiteral(resourceName: "Capa 4"),#imageLiteral(resourceName: "Capa 3"),#imageLiteral(resourceName: "Capa 2"),#imageLiteral(resourceName: "Capa 7")]
    @IBOutlet weak var likebtnView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var innerCard: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.title = "Detalle"
        collectionView.dataSource = self
        collectionView.delegate = self
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        dishPriceLabel.layer.cornerRadius = 15
        dishPriceLabel.layer.masksToBounds = true
        innerCard.layer.cornerRadius = 15
        innerCard.layer.masksToBounds = true
       likebtnView.layer.cornerRadius = likebtnView.frame.height/2
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                 4
             }
             
       public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDish", for: indexPath) as! DishesSliderCollectionViewCell
        
        cell.dishesImageView.image = images [indexPath.item]
              return cell
             }
          

}
