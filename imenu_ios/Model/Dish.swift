//
//  Dish.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 21/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class Dish {
    var name:String?
    var description:String?
    var menuBelonged:Int?
    var image:UIImage?
    
    
    init(name:String?, description:String?, menuBelonged:Int?, image:UIImage?) {
        self.name = name!
        self.description = description!
        self.menuBelonged = menuBelonged!
        self.image = image
    }
}
