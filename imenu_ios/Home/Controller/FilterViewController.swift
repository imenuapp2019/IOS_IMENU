//
//  FilterViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 07/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class FilterViewController{
    
    func AllOn(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        var value:Bool = false
        if (first && second && third){
            value = true
        }else{
            value = false
        }
        return value
    }
    
    func TwoOn(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        var value:Bool = false
        if ((first && second)||(first && third)||(second && third)){
            value = true
        }else{
            value = false
        }
        return value
    }
    
    func oneOne(First first:Bool,Second second:Bool, Third third:Bool) -> Bool {
        var value:Bool = false
        if (first || second || third){
            value = true
        }else{
            value = false
        }
        return value
    }
  
}
