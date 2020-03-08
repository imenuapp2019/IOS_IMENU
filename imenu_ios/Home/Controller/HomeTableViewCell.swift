//
//  HomeTableViewCell.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 24/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var nameRestaurant: UILabel!
    @IBOutlet weak var typeRestaurant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.alpha = 0
        self.backgroundColor = .clear
        self.shadowView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func circleImage(){
        restaurantImage.layer.cornerRadius = restaurantImage.frame.size.width/20
        viewOpacity.layer.cornerRadius = 12
    }
    
    func shadowView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
