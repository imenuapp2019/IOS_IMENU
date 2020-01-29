//
//  HomeViewController.swift
//  
//
//  Created by Miguel Jaimes on 22/01/2020.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    /**
     
     */
    @IBOutlet weak var searchButton: UIButton!
       @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var AlertView: UIView!
    @IBOutlet weak var LabelAlertView: UILabel!
    
    
       /**
        Collection View Cell side, properties and declarations.
    **/
       @IBOutlet weak var gridRestaurant: UICollectionView!
   
    

    
    var listRestaurants : [Restaurant] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let child = UIView()
        child.translatesAutoresizingMaskIntoConstraints = false
        child.backgroundColor = .red
        view.addSubview(child)
        child.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = false
        child.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        child.widthAnchor.constraint(equalToConstant: 128).isActive = true
    
        child.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        /**
                    Alert View Properties
         */
        LabelAlertView.text = Literals.labelAlertView
        AlertView.layer.cornerRadius = 20
        AlertView.alpha = 0.0
        
        /**
         Collection View Restuarnts and Properties
         */
        self.listRestaurants = dataHardcoded()
        
        self.gridRestaurant.dataSource = self
        self.gridRestaurant.delegate = self
        
        
        setHeader()
                
        print("Restaurantes:",listRestaurants.count)
        print("Restaurante;",listRestaurants[0].image!)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.gridRestaurant.setNeedsDisplay()
        self.gridRestaurant.reloadData()

    }
    
    
    func dataHardcoded()->[Restaurant]{
        var listRestaurants :[Restaurant]=[]
        listRestaurants.append(Restaurant(name: "Restaurante Zalacaín", type: "Alta Cocina", urlImage: "fotoRestaurante1", latitude: 1.90, longitude: 2.20))
        listRestaurants.append(Restaurant(name: "Restaurante Vertical", type: "Cocina de Vanguardia", urlImage: "FotoRestauranteDos", latitude: 2.60, longitude: 5.00))
        listRestaurants.append(Restaurant(name: "Restaurante Horizontal", type: "Cocina Española", urlImage: "FotoRestauranteDos", latitude: 2.800, longitude: 5.00))
        
        return listRestaurants
    }

/**Collection view functions*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRestaurants.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let restaurant = listRestaurants[indexPath.row]
       // print("imagen",restaurant.image!);
        let identifier = "Restaurant"
        let cell = self.gridRestaurant.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)as! RestaurantCollectionView
        cell.imageRestaurant.image = UIImage(imageLiteralResourceName: restaurant.image!)
        cell.nameRestaurant.text = restaurant.name
        cell.typeRestaurant.text = restaurant.type
        
        return cell
        
    }
    /**
     Event direction of scrolling
     */
    var lastVelocityYSign = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
           currentVelocityYSign != 0 {
               lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign < 0 {
            setView(view: AlertView, hidden: false)
        } else if lastVelocityYSign > 0 {
            setView(view: AlertView, hidden: true)
          print("SCOLLING UP")
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        if(hidden == false){
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                view.alpha = 1.0
            })
        }else{
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                view.alpha = 0.0
                
            })
        }
        
    }
    
    func setHeader() {
        filterButton.setBackgroundImage(UIImage(named: "iconFilter"), for: .normal)
        searchButton.setBackgroundImage(UIImage(named: "iconoLupa"), for: .normal)
        filterButton.setTitle("", for: .normal)
        searchButton.setTitle("", for: .normal)
    }
}
