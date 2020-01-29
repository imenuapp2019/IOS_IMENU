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
    
    @IBOutlet weak var LabelTypeFood: UILabel!
    
    @IBOutlet weak var LabelPrice: UILabel!
    
    @IBOutlet weak var LabelDistance: UILabel!
    
    @IBOutlet weak var TypeFoodView: UIView!
    @IBOutlet weak var SelectFilter: UIButton!
    
    @IBOutlet weak var ButtonClose: RoundButton!
    /**
     Selector del tipo de comida.
     */
     let data = [["Mexicano","Hindu","Tailandesa","Española"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelPrice.text = Literals.labelFilterPrice
        LabelTypeFood.text = Literals.labelFilterTP
        LabelDistance.text = Literals.labelFilterDistance
        SelectFilter.layer.cornerRadius = 10;
        ButtonClose.setTitle(Literals.btnFilter, for: .normal)
    }
    @IBAction func SelectAction(_ sender: Any) {
        
        McPicker.show(data: data) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                 self?.SelectFilter.setTitle(name, for: .normal)
            }
           
            
        }
    }
    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
