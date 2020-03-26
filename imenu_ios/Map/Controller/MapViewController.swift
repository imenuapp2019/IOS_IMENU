//
//  MapViewController.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 03/03/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var labelDT: UILabel!
    let locationManager = CLLocationManager ()
    let latitudinalMeters:Double = 1000
    let longitudinalMeters:Double = 1000
    var previousLocation:CLLocation?
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    var directionsArray:[MKDirections] = []
    
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    @IBOutlet weak var roundedImageview: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func centerBtn(_ sender: Any) {
          centerViewOnUserLocation()
     }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addAnotation()
        checkLocationServices()
        configureCollectionView()
        roundedImageview.layer.cornerRadius = roundedImageview.frame.height/2
        datafromServer()

         self.restaurantsCollectionView.reloadData()
    }
    
    
    var listRestaurants : [RestaurantElement] = [] {
           didSet {
               self.restaurantsCollectionView.reloadData()
           }
       }
    
                    //Network
    
    
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
            let url = result.urlImage()
               if url == nil {
                   return false
               }else{
                   return true
               }
           })
           self.listRestaurants = newRestaurant
       }
    
    
    
    
    
    
                        //CollectionView
    
  func configureCollectionView () {
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
        collectionViewFlowLayout = UICollectionViewFlowLayout ()
        collectionViewFlowLayout.itemSize = CGSize(width: 157, height: 146)
        collectionViewFlowLayout.scrollDirection = .horizontal
        restaurantsCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageDownloader = ImageDownloader()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsInMapViewCell", for: indexPath) as! MapCollectionViewCell
        
    
        let restaurant = listRestaurants[indexPath.row]
        let urlRestaurant = restaurant.urlImage()
        imageDownloader.downloader(URLString: urlRestaurant, completion: { (image:UIImage?) in
                   cell.restaurantImage.image = image
               })
        cell.restaurantName.setTitle(restaurant.nombre, for: .normal)
        cell.latitud = restaurant.latitud
        cell.longitud = restaurant.longitud
        
        cell.contentView.layer.cornerRadius = 30
        cell.clipsToBounds = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DoWhenACellIsClicked(_:))))
        
        return cell
    }
    
    @objc func DoWhenACellIsClicked(_ sender: UITapGestureRecognizer) {
        
        let point:CGPoint = sender.location(in: restaurantsCollectionView)
        let index = restaurantsCollectionView.indexPathForItem(at:point)
        
        let cell = restaurantsCollectionView.cellForItem(at: index!) as! MapCollectionViewCell
        
        centerViewToRestaurantOrAnnotationClicked(latitude: cell.latitud!, longitude: cell.longitud!)
    
       
       }
                    //Map / Location
    
    func centerViewToRestaurantOrAnnotationClicked (latitude:Double, longitude:Double) {
    //this one
        let point = CLLocationCoordinate2D( latitude: latitude,  longitude: longitude)
         //let point = CLLocationCoordinate2D( latitude: 40.438969,  longitude: -3.713025)
                   
                   let region = MKCoordinateRegion.init(center: point, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
                   mapView.setRegion(region, animated: true)
    }
    
    func addAnotation () {
         let point = CLLocationCoordinate2D( latitude:40.438969 ,  longitude: -3.713025)
            let anotation = MKPointAnnotation()
           anotation.coordinate = point
           anotation.title = "Friday"
        
        let point2 = CLLocationCoordinate2D( latitude:40.436659 ,  longitude: -3.718054)
         let anotation2 = MKPointAnnotation()
        anotation2.coordinate = point2
        anotation2.title = "Friday"
        
           mapView.addAnnotation(anotation)
         mapView.addAnnotation(anotation2)
    }
    
    
    func centerViewOnUserLocation () {
          
        if let location = locationManager.location?.coordinate {
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
            mapView.setRegion(region, animated: true)
        }
      }
    
    func checkLocationServices () {
    //Check if location is enable on the device
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            
        } else {
             //Alerta que el usuario debe activar la localización del dispositivo
        }
    }
    
    
    func setupLocationManager () {
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
           startTrackingUserLocation()
        case .denied:
             break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
             break
        case .restricted:
             break
        case .authorizedAlways:
             break
    
        @unknown default:
            print ("")
        }
        
    }
    func startTrackingUserLocation () {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
        
    }
    
    
    func getDirections () {
        
        guard let location = locationManager.location?.coordinate else {
            
            return
        }
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections (request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            
            guard let response = response else {return}
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
            }
            
        }
    }
    
    func createDirectionsRequest (from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        
        let destinationCoordinate           = getCenterLocation(for: mapView).coordinate
        let startingLocation                =  MKPlacemark(coordinate: coordinate)
        let destination                     = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                         = MKDirections.Request()
        request.source                      = MKMapItem(placemark: startingLocation)
        request.destination                 = MKMapItem(placemark: destination)
        request.transportType               = .walking
        request.requestsAlternateRoutes     = false
        
        
        return request
    }
    
    func resetMapView (withNew directions:MKDirections) {
        
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
       // let _ directionsArray.map {$0.remove}

    }
    
    
//    func addMarkers (data: [ResponseRecyclePoint]) {
//
//           for items in data {
//               let point = CLLocationCoordinate2D( latitude: items.latitud!,  longitude: items.longitud!
//               )
//               let anotation = MKPointAnnotation()
//               anotation.coordinate = point
//               anotation.title = items.name
//               mapView.addAnnotation(anotation)
//           }
//
//       }
    
    func getCenterLocation (for mapView:MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
  
}
extension MapViewController: CLLocationManagerDelegate {
    
    
    //mientras se mueve el usuario
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region =  MKCoordinateRegion.init(center: center , latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
//        mapView.setRegion(region, animated: true)
//
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       // centerViewToRestaurantOrAnnotationClicked(latitude: , longitude: <#T##Double#>)
        getDirections()
        print ("Hola")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder ()
        
        guard let previousLocation = self.previousLocation else {return}
       
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
       
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            
                if let _ = error {
                    
                    return
                }
            
            guard let placemark = placemarks?.first else {
                
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
           
            DispatchQueue.main.async {
                print ("Hola")
                self.labelDT.text = "\(streetNumber) \(streetName)"
                print(streetNumber)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .green
        return renderer
    }
}
