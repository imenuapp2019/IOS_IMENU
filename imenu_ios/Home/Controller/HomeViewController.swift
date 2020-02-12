//
//  HomeViewController.swift
//  
//
//  Created by Miguel Jaimes on 22/01/2020.
//

import UIKit
import PopupDialog

class HomeViewController: BaseViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    

    @IBAction func filterClicked(_ sender: Any) {
       
    }
    
    
    @IBAction func searchClicker(_ sender: Any) {
    }
    
    @IBOutlet var filterView: UIView!
    @IBOutlet weak var oneChecker: UIView!
    
    @IBOutlet weak var twoChecker: UIView!
    @IBOutlet weak var threeChecker: UIView!
    
    
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var AlertView: UIView!
    @IBOutlet weak var LabelAlertView: UILabel!
    @IBOutlet weak var gridRestaurant: UICollectionView!
    
    var listRestaurants : [RestaurantElement] = [] {
        didSet {
            self.gridRestaurant.reloadData()
        }
    }
    
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
        
        LabelAlertView.text = Literals.labelAlertView
        AlertView.layer.cornerRadius = 20
        AlertView.alpha = 0.0
        
        self.datafromServer()
        
        self.gridRestaurant.delegate = self
        self.gridRestaurant.dataSource = self
        
        setHeader()
        self.addNavBarImage()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.gridRestaurant.setNeedsDisplay()
        self.gridRestaurant.reloadData()
    }
    
    func addNavBarImage() {
        let navController = navigationController!
        let image = UIImage(named: "LOGOIMENUDishView") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func datafromServer(){
        print("Llamo")
        let apirest = APIManager()
        apirest.getAllRestaurants(completion: { result
            in
            let resultsRestaurants = result.first
            print(resultsRestaurants)
            self.createListRestaurant(List: resultsRestaurants)
        })
    }
    
    func createListRestaurant(List list:Restaurant?){
        guard let listRestaurants = list else { return }
        let newRestaurant = listRestaurants.filter( {
            result in
            if result.imageURL == nil {
                return false
            }else{
                return true
            }
        })
        self.listRestaurants = newRestaurant
    }
    
    func dataHardcoded()->[RestaurantElement]{
        var listRestaurants :[RestaurantElement]=[]
        listRestaurants.append(RestaurantElement(name: "Restaurante Zalacaín", type: "Alta Cocina", urlImage: "fotoRestaurante1", latitude: 1.90, longitude: 2.20))
        listRestaurants.append(RestaurantElement(name: "Restaurante Vertical", type: "Cocina de Vanguardia", urlImage: "FotoRestauranteDos", latitude: 2.60, longitude: 5.00))
        listRestaurants.append(RestaurantElement(name: "Restaurante Horizontal", type: "Cocina Española", urlImage: "FotoRestauranteDos", latitude: 2.800, longitude: 5.00))
        
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
        let imageDownloader = ImageDownloader()
        let restaurant = listRestaurants[indexPath.row]
        let identifier = "Restaurant"
        let cell = self.gridRestaurant.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)as! RestaurantCollectionView
        imageDownloader.downloader(URLString: restaurant.imageURL!, completion: { (image:UIImage?) in
            cell.imageRestaurant.image = image
        })
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = ( sender as? RestaurantCollectionView) else { return }
        guard let indexPath = self.gridRestaurant.indexPath(for: item) else { return }
        let restaurant = listRestaurants[indexPath.row]
        let detailRestaurant = segue.destination as? MenuViewController
        detailRestaurant?.restaurant = restaurant
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8, animations: {
            cell.alpha = 1
        })
    }
}





