//
//  ViewController.swift
//  Bounce
//
//  Created by Prithviraj Murthy on 18/07/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class customPin: NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var pinTitle:String
    
    init(pinTitle:String,location:CLLocationCoordinate2D){
        self.pinTitle = pinTitle
        self.coordinate = location
    }
}
class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var currentLoc: UIButton!
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var Bike: UIButton!
    @IBOutlet weak var Car: UIButton!
    
    var newEstimatedPrice : String!
    var newArrivalTime : String!
    
    var estimatedPrice : String = "Estimated Price: Rs. 300"
    var ArrivalTime : String = "Travel Time: 32 minutes"

    var newInfo : Bool = false
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Bike.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.lightPink)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsPointsOfInterest = true
        mapKitView.showsUserLocation = true
        
        
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapKitView.setRegion(viewRegion, animated: false)
        }
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        print("NEW INFO \(newInfo)")
        if newInfo {
            performSegue(withIdentifier: "RideInfo", sender: self)
        }
    
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    @IBAction func getCurrentLoc(_ sender: Any) {
        MKUserTrackingBarButtonItem(mapView: mapKitView)
    }
    @IBAction func bikePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "RideInfo", sender: self)
        
        let sourceCoordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let ShopCoordinates = CLLocationCoordinate2D(latitude: 18.518803, longitude: 73.815405)
        let regionDistance : CLLocationDistance = 1000
        let regionSpan = MKCoordinateRegion(center: ShopCoordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        
        //        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        
        let sourceMarker = MKPlacemark(coordinate: sourceCoordinates)
        let sourceItem = MKMapItem(placemark: sourceMarker)
        let ShopMarker = MKPlacemark(coordinate: ShopCoordinates)
        let mapItem = MKMapItem(placemark: ShopMarker)
        mapKitView.addAnnotation(customPin(pinTitle: "Your Location", location: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)))
        
        mapKitView.addAnnotation(customPin(pinTitle: "Destination", location: CLLocationCoordinate2D(latitude: 18.518803, longitude: 73.815405)))
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = mapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("WRONG")
                }
                return
            }
            let route = response.routes[0]
            self.mapKitView.addOverlay(route.polyline,level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mapKitView.setRegion(MKCoordinateRegion(rekt),animated: true)
            self.performSegue(withIdentifier: "RideInfo", sender: self)

        }
        
        mapItem.name = "Shop1"
        mapItem.openInMaps(launchOptions: launchOptions as! [String : Any])
        
        
    }
    
    
    
    
    @IBAction func carPressed(_ sender: Any) {
        

        
        let sourceCoordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let ShopCoordinates = CLLocationCoordinate2D(latitude: 18.518803, longitude: 73.815405)
        let regionDistance : CLLocationDistance = 1000
        let regionSpan = MKCoordinateRegion(center: ShopCoordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        
        //        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        
        let sourceMarker = MKPlacemark(coordinate: sourceCoordinates)
        let sourceItem = MKMapItem(placemark: sourceMarker)
        let ShopMarker = MKPlacemark(coordinate: ShopCoordinates)
        let mapItem = MKMapItem(placemark: ShopMarker)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = mapItem
        directionRequest.transportType = .automobile
        mapKitView.addAnnotation(customPin(pinTitle: "Your Location", location: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)))
        
        mapKitView.addAnnotation(customPin(pinTitle: "Destination", location: CLLocationCoordinate2D(latitude: 18.518803, longitude: 73.815405)))
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("WRONG")
                }
                return
            }
            let route = response.routes[0]
            self.mapKitView.addOverlay(route.polyline,level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mapKitView.setRegion(MKCoordinateRegion(rekt),animated: true)
            self.performSegue(withIdentifier: "RideInfo", sender: self)

        }
        
        mapItem.name = "Shop1"
        mapItem.openInMaps(launchOptions: launchOptions as! [String : Any])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RideInfo" {
            let VC = segue.destination as! RideInfoVC
            if !newInfo{
                print("ES \(estimatedPrice) & AT \(ArrivalTime)")
                VC.price = estimatedPrice
                VC.ArrivalTime = ArrivalTime
                
            }else{
                 VC.price  = newEstimatedPrice
                VC.ArrivalTime = newArrivalTime
            }
        }
    }
}

