//
//  FilterViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 07/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class FilterViewController{
    
    var value:Bool = false
    
    func AllOn(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        if (first && second && third){
            value = true
        }else{
            value = false
        }
        return value
    }
    
    func TwoOn(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        if ((first && second && !third)||(first && !second && third)||(!first && second && third)){
            value = true
        }else{
            value = false
        }
        return value
    }
    
    func oneOn(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        if (first && !second && !third)||(!first && second && !third)||(!first && !second && third){
            value = true
        }else{
            value = false
        }
        return value
    }
    
    func none(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        if (!first && !second && !third){
            value = true
        }else{
            value = false
        }
        return value
    }
  
}
