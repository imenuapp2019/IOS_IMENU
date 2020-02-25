//
//  HomeViewController.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 24/02/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - SearchBar
    var searchBarWithDelegate: DAOSearchBar!
    let innerSpacing: CGFloat = 100.0
    let marginX: CGFloat = 50.0
    let marginY: CGFloat = 25
    let searchBarHeight: CGFloat = 30.0
    let searchBarOriginalWidth: CGFloat = 44.0
    var searchBarWidth: CGFloat = 310.0
    var searchBarDestinationFrame = CGRect.zero
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var labelAlertView: UILabel!
    
    var lastVelocityYSign = 0
    
    var listRestaurants : [RestaurantElement] = [] {
        didSet {
            self.homeTableView.reloadData()
        }
    }
    
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.reloadData()
        delegates()
        setupSearchBars()
        setupInitValues()
        setUpView()
        datafromServer()
    }
    
    func setUpView(){
        homeTableView.backgroundColor = .clear
        labelAlertView.text = Literals.labelAlertView
        alertView.layer.cornerRadius = 15
        alertView.alpha = 0.0
    }
    
    func datafromServer(){
        let apirest = APIManager()
        apirest.getAllRestaurants(completion: { result
            in
            let resultsRestaurants = result.first
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
    
    func delegates(){
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
    }
    
    func setupSearchBars(){
        let searchBarWithDelegate = DAOSearchBar.init(frame: CGRect(x: marginX, y: marginY, width: searchBarOriginalWidth, height: searchBarHeight))
        var frame = searchBarWithDelegate.frame
        frame.size.width = searchBarWidth
        self.searchBarDestinationFrame = frame
        searchBarWithDelegate.delegate = self
        self.view.addSubview(searchBarWithDelegate)
    }
    
    func setupInitValues () {
        searchBarWidth = self.view.bounds.width - (2 * marginX)
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = listRestaurants.count
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageDownloader = ImageDownloader()
        let restaurant = listRestaurants[indexPath.row]
        let identifier = "HomeRestaurant"
        let cell = self.homeTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)as! HomeTableViewCell
        imageDownloader.downloader(URLString: restaurant.imageURL!, completion: { (image:UIImage?) in
            cell.restaurantImage.image = image
        })
        cell.nameRestaurant.text = restaurant.name
        cell.typeRestaurant.text = restaurant.type
        cell.backgroundColor = .clear
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign &&
            currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign < 0 {
            self.setView(view: alertView, hidden: false)
        } else if lastVelocityYSign > 0 {
            self.setView(view: alertView, hidden: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8,delay: 0.5,options: .curveEaseOut, animations: {
            cell.alpha = 1
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = ( sender as? HomeTableViewCell) else { return }
        guard let indexPath = self.homeTableView.indexPath(for: item) else { return }
        let restaurant = listRestaurants[indexPath.row]
        let detailRestaurant = segue.destination as? MenuViewController
        detailRestaurant?.restaurant = restaurant
    }
    
}

extension HomeViewController: DAOSearchBarDelegate {
    // MARK: SearchBar Delegate
    func destinationFrameForSearchBar(_ searchBar: DAOSearchBar) -> CGRect {
        return self.searchBarDestinationFrame
    }
    
    func searchBar(_ searchBar: DAOSearchBar, willStartTransitioningToState destinationState: DAOSearchBarState) {
        // Do whatever you deem necessary.
    }
    
    func searchBar(_ searchBar: DAOSearchBar, didEndTransitioningFromState previousState: DAOSearchBarState) {
        // Do whatever you deem necessary.
    }
    
    func searchBarDidTapReturn(_ searchBar: DAOSearchBar) {
        // Do whatever you deem necessary.
        // Access the text from the search bar like searchBar.searchField.text
    }
    
    func searchBarTextDidChange(_ searchBar: DAOSearchBar) {
        // Do whatever you deem necessary.
        // Access the text from the search bar like searchBar.searchField.text
    }
}


