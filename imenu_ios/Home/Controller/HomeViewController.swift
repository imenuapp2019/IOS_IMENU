//
//  HomeViewController.swift
//  
//
//  Created by Miguel Jaimes on 22/01/2020.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.setBackgroundImage(UIImage(named: "iconFilter"), for: .normal)
        searchButton.setBackgroundImage(UIImage(named: "iconoLupa"), for: .normal)
        filterButton.setTitle("", for: .normal)
        searchButton.setTitle("", for: .normal)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
