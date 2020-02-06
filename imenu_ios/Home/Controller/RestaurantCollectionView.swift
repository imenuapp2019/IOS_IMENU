//
//  RestaurantCollectionView.swift
//  imenu_ios
//
//  Created by Loren on 23/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
class RestaurantCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var typeRestaurant: UILabel!
    @IBOutlet weak var nameRestaurant: UILabel!
    @IBOutlet weak var CardBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 7
        self.shadowView()
    }
    
    func shadowView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
