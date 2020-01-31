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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 7
       
    }
    
}
