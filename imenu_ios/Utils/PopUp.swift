//
//  POPUP.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 22/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit



class PopUp {
    
    func initializade(Title title:String, Message message:String) -> UIAlertController  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
}
