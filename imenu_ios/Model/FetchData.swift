//
//  fetchData.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 28/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation
import UIKit
class FetchData{
    
//    var menuSection = 1
//
//    func setSection (section:Int) {
//
//        menuSection = section
//    }
    func fetchDishes (sectionIndex:Int) -> [Dish] {
        
        switch sectionIndex {
        case 0:
            
                let bebida1 = Dish(name: "Agua", description: "Agua mineral o con gas al gusto", menuBelonged: 1, image:UIImage(named: "agua"), price: 3)
                         
             let bebida2 = Dish(name: "Cervezas", description: "Cervezas importadas y artesanales", menuBelonged: 2, image: UIImage(named: "cervezas"), price: 5)
                         
             let bebida3 = Dish(name: "Vinos", description: "Variedad de vinos y vinos espumosos. Blancos, tintos y rosados", menuBelonged: 3, image: UIImage(named: "vinos"), price: 7)
            let bebida4 = Dish(name: "Refrescos", description: "Gran variedad de refrescos, locales y de importación", menuBelonged: 1, image:UIImage(named: "refrescos"), price: 3)
                                    
            let bebida5 = Dish(name: "Café", description: "Gran variedad de café. Drisfrute de diferentes intensidades y sabores", menuBelonged: 2, image: UIImage(named: "cafe"), price: 3)
            
            let bebida6 = Dish(name: "Infusiones", description: "Gran variedad de infusiones. Drisfrute de diferentes intensidades y sabores", menuBelonged: 2, image: UIImage(named: "te"), price: 3)
                
            let bebida7 = Dish(name: "Destilados", description: "Destilados", menuBelonged: 2, image: UIImage(named: "destilados"), price: 15)
                
             return [bebida1, bebida2, bebida3, bebida4, bebida5,bebida6, bebida7]
            case 1:
        
            
            let dish1 = Dish(name: "Pollo al horno", description: "Pollo hecho al horno", menuBelonged: 1, image: #imageLiteral(resourceName: "HDpollo"), price: 10)
              
              let dish2 = Dish(name: "Pizza barbacoa", description: "Pizza con ternera y salsa barbacoa", menuBelonged: 2, image: #imageLiteral(resourceName: "HD_Pizza"), price: 40)
              
              let dish3 = Dish(name: "Tarta de queso", description: "Tarta de queso, nata y frambuesas", menuBelonged: 3, image: #imageLiteral(resourceName: "HD_tarta"), price: 20)
              
            
              
              
              return [dish1, dish2, dish3,dish1, dish2, dish3,dish1, dish2, dish3,dish1, dish2, dish3 ]
            
        default:
            let dish1 = Dish(name: "Pollo al horno", description: "Pollo hecho al horno", menuBelonged: 1, image: #imageLiteral(resourceName: "HDpollo"), price: 10)
              
              let dish2 = Dish(name: "Pizza barbacoa", description: "Pizza con ternera y salsa barbacoa", menuBelonged: 2, image: #imageLiteral(resourceName: "HD_Pizza"), price: 40)
              
              let dish3 = Dish(name: "Tarta de queso", description: "Tarta de queso, nata y frambuesas", menuBelonged: 3, image: #imageLiteral(resourceName: "HD_tarta"), price: 20)
              
            
              
              
              return [dish1, dish2, dish3,dish1, dish1 ]
            
        }
        
    }
    
    
    
}


