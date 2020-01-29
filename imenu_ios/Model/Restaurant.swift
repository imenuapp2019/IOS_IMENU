//
//  Restaurant.swift
//  imenu_ios
//
//  Created by Loren on 23/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class Restaurant : Codable{
    var name :String?, type:String?,image: String?
    var coordinates: [Double]=[]
    init(name:String,type:String,urlImage:String,latitude:Double,longitude:Double){
        if(!name.isEmpty && !type.isEmpty && !urlImage.isEmpty && !latitude.isNaN && !longitude.isNaN){
            self.name = name
            self.type = type
            self.image = urlImage
            self.coordinates.append(latitude)
            self.coordinates.append(longitude)
        }
    }
    init(jsonList: NSDictionary){
        
    }
    
    
    
    
}
