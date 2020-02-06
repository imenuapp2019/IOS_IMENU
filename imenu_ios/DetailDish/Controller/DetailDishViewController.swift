//
//  DetailDishViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class DetailDishViewController: UIViewController {

    
    @IBOutlet weak var likebtnView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var innerCard: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.title = "Detalle"
        
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        dishPriceLabel.layer.cornerRadius = 15
        dishPriceLabel.layer.masksToBounds = true
        innerCard.layer.cornerRadius = 15
        innerCard.layer.masksToBounds = true
       likebtnView.layer.cornerRadius = likebtnView.frame.height/2
    }
    
}
