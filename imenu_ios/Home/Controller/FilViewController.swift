//
//  FilterViewController.swift
//  imenu_ios
//
//  Created by Loren on 28/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import McPicker
class FilViewController: UIViewController {
    
    @IBOutlet weak var TypeFoodView: UIView!
    @IBOutlet weak var SelectFilter: UIButton!
    
    @IBOutlet weak var SelectViewFilter: UIView!
    /**
     Selector del tipo de comida.
     */
     let data = [["Mexicano","Hindu","Tailandesa","Española"]]
    override func viewDidLoad() {
        super.viewDidLoad()
       // SelectViewFilter.layer.cornerRadius = 10;
    }
    @IBAction func SelectAction(_ sender: Any) {
        
        McPicker.show(data: data) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                 self?.SelectFilter.setTitle(name, for: .normal)
            }
           
            
        }
    }
}
