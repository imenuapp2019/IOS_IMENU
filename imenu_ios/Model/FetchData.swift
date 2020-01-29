//
//  fetchData.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 28/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation
class FetchData{
    func fetchDishes () -> [Dish] {
        let dish1 = Dish(name: "Pollo al horno", description: "Pollo hecho al horno", menuBelonged: 1, image: #imageLiteral(resourceName: "HDpollo"))
        
        let dish2 = Dish(name: "Pizza barbacoa", description: "Pizza con ternera y salsa barbacoa", menuBelonged: 2, image: #imageLiteral(resourceName: "HD_Pizza"))
        
        let dish3 = Dish(name: "Tarta de queso", description: "Tarta de queso, nata y frambuesas", menuBelonged: 3, image: #imageLiteral(resourceName: "HD_tarta"))
        
      
        
        
        return [dish1, dish2, dish3,dish1, dish2, dish3,dish1, dish2, dish3,dish1, dish2, dish3 ]
    }
    
}


