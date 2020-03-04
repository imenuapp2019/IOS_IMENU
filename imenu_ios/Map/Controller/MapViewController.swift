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
    
    @IBAction func centerBtn(_ sender: Any) {
         centerViewOnUserLocation()
    }
    let locationManager = CLLocationManager ()
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    @IBOutlet weak var roundedImageview: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        roundedImageview.layer.cornerRadius = roundedImageview.frame.height/2
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
        collectionViewFlowLayout = UICollectionViewFlowLayout ()
         collectionViewFlowLayout.itemSize = CGSize(width: 105, height: 82)
        collectionViewFlowLayout.scrollDirection = .horizontal
        restaurantsCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
       
    }
    
                        //CollectionView
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsInMapViewCell", for: indexPath) as! MapCollectionViewCell
        
          cell.clipsToBounds = true
        return cell
    }
    
    
                    //Map / Location
    
    func centerViewOnUserLocation () {
          
        if let location = locationManager.location?.coordinate {
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
             centerViewOnUserLocation()
           
            break
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
}
extension MapViewController: CLLocationManagerDelegate {
    
    
    
}
