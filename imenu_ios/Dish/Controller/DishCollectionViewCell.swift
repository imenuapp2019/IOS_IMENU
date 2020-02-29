//
//  DishCollectionViewCell.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class DishCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var DishImageView: UIImageView!
    
    @IBOutlet weak var gradientImageView: UIImageView!
    
    @IBOutlet weak var dishNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        applyGradient()
        
    }

    
    private func applyGradient () {
        
        let view = UIView(frame:DishImageView.frame)
        
        let gradient = CAGradientLayer()
        
        gradient.frame = view.frame
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        gradient.locations = [0.0, 1.0]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        gradientImageView.addSubview(view)
        
        gradientImageView.bringSubviewToFront(view)
    }
    
   
}
