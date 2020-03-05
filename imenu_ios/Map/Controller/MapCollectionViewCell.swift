//
//  MapCollectionViewCell.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 03/03/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ContentView: MapCollectionViewCell!
   
    @IBOutlet weak var nameBtn: UIButton!
    
    @IBOutlet weak var restaurantName: UIButton!
    @IBOutlet weak var restaurantImage: UIImageView!
    
   
    var longitud:Double?
    var latitud:Double?
    
    
}
