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
            let entrante1 = Dish(name: "Rollitos de berenjena", description: "Rollitos de berenjena rellenos de queso y salsa a elegir", menuBelonged: 1, image:UIImage(named: "rollitos_this"), price: 3)
                                    
            let entrante2 = Dish(name: "Dedos de mozarella", description: "Crujientes y relleno del mejor queso", menuBelonged: 2, image: UIImage(named: "mozarella_this"), price: 5)
            
            let entrante3 = Dish(name: "Alitas", description: "Alitas picantes", menuBelonged: 1, image:UIImage(named: "alitas_this"), price: 3)
                                                
            let entrante4 = Dish(name: "Nachos", description: "Con queso o guacamole. !Tú eliges!", menuBelonged: 2, image: UIImage(named: "nachos_this"), price: 5)
                                                
                return [entrante1, entrante2, entrante3 , entrante4]
            
        case 1:
                  let primero1 = Dish(name: "Ensalada Cesar", description: "Ensalada Cesar", menuBelonged: 1, image:UIImage(named: "cesar_this"), price: 3)
                  
                    let primero2 = Dish(name: "Ensalada de pasta", description: "Ensalada de pasta, atún y tomate", menuBelonged: 1, image:UIImage(named: "ensaladaPasta_this"), price: 3)
                  
                        let primero3 = Dish(name: "Gazpacho", description: "Gazpacho de tomates frescos", menuBelonged: 1, image:UIImage(named: "gazpacho_this"), price: 3)
                  
                    let primero4 = Dish(name: "Salmorejo", description: "Salmorejo", menuBelonged: 1, image:UIImage(named: "salmorejo_this"), price: 3)
            return [primero1, primero2, primero3, primero4]
            
            
        case 2:
        let segundo1 = Dish(name: "Risotto", description: "Risotto description", menuBelonged: 1, image:UIImage(named: "risotto_this"), price: 3)
        let segundo2 = Dish(name: "Carne a la parilla", description: "Carne a la parrilla descrption", menuBelonged: 1, image:UIImage(named: "carne_this"), price: 3)
        let segundo3 = Dish(name: "Salmón", description: "salmon description", menuBelonged: 1, image:UIImage(named: "salmon_this"), price: 3)
        let segundo4 = Dish(name: "Lasaña", description: "Lasaña description", menuBelonged: 1, image:UIImage(named: "lasaña_this"), price: 3)
            
            return [segundo1, segundo2, segundo3, segundo4]
            
        case 3:
               let postre1 = Dish(name: "Helados", description: "Helados description", menuBelonged: 1, image:UIImage(named: "helado_this"), price: 3)
               let postre2 = Dish(name: "Tartas", description: "tartas Description", menuBelonged: 1, image:UIImage(named: "tarta_this"), price: 3)
               let postre3 = Dish(name: "Flan", description: "Flan description", menuBelonged: 1, image:UIImage(named: "flan_this"), price: 3)
               let postre4 = Dish(name: "Yogur", description: "Yogur description", menuBelonged: 1, image:UIImage(named: "yogurt_this"), price: 3)
        
            return [postre1, postre2, postre3, postre4]
        case 4:
            let bebida1 = Dish(name: "Agua", description: "Agua mineral o con gas al gusto", menuBelonged: 1, image:UIImage(named: "agua"), price: 3)
                         
             let bebida2 = Dish(name: "Cervezas", description: "Cervezas importadas y artesanales", menuBelonged: 2, image: UIImage(named: "cervezas"), price: 5)
                         
             let bebida3 = Dish(name: "Vinos", description: "Variedad de vinos y vinos espumosos. Blancos, tintos y rosados", menuBelonged: 3, image: UIImage(named: "vinos"), price: 7)
            let bebida4 = Dish(name: "Refrescos", description: "Gran variedad de refrescos, locales y de importación", menuBelonged: 1, image:UIImage(named: "refrescos"), price: 3)
                                    
            let bebida5 = Dish(name: "Café", description: "Gran variedad de café. Drisfrute de diferentes intensidades y sabores", menuBelonged: 2, image: UIImage(named: "cafe"), price: 3)
            
            let bebida6 = Dish(name: "Infusiones", description: "Gran variedad de infusiones. Drisfrute de diferentes intensidades y sabores", menuBelonged: 2, image: UIImage(named: "te"), price: 3)
                
            let bebida7 = Dish(name: "Destilados", description: "Destilados", menuBelonged: 2, image: UIImage(named: "destilados"), price: 15)
                
             return [bebida1, bebida2, bebida3, bebida4, bebida5,bebida6, bebida7]
            
        default:
           
           let especial1 = Dish(name: "Ramen", description: "Ramen Description", menuBelonged: 1, image:UIImage(named: "ramen_this"), price: 3)
           let especial2 = Dish(name: "Yakisoba", description: "Yakisoba description", menuBelonged: 1, image:UIImage(named: "yakisoba_this"), price: 3)
              
              
              return [especial1, especial2]
            
        }
        
    }
    
    
    
}


