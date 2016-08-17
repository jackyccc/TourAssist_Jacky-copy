//
//  GPSNavigationViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/4/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class GPSNavigationViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    var TRLongitude:Double!
    var TRLatitude:Double!
    var isFromDetailView:Bool!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        ref = FIRDatabase.database().reference()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenterCoordinate(coor, animated: true)
        }
        
        
  
        
        
//        ref.child("users").queryOrderedByChild("uid").queryEqualToValue(LoginInstance.keyID).observeEventType(.ChildAdded, withBlock: { snapshot in
//            //if let lastname = snapshot.value!["lastname"] as? String {
//            //print(lastname)
//            let LName = snapshot.value!["lastname"] as? String
//            let FName = snapshot.value!["firstname"] as? String
//            let emailAdd = snapshot.value!["email"] as? String
//            //let isTourist = snapshot.value!["isTourist"] as? Bool
//            let phone = snapshot.value!["phone"] as? String
//            let nationality = snapshot.value!["nationality"] as? String
//            let language = snapshot.value!["language"] as? String
//            let sex = snapshot.value!["sex"] as? String
//            let imgStr = snapshot.value!["image"] as? String
//            let key = snapshot.value!["uid"] as? String
//            
//
//            
//            
//            
//        })
//

        
        //let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.000000, longitude: -0.10000), info: "whatever info about london")
        //let newYork = Capital(title: "New York", coordinate: CLLocationCoordinate2D(latitude: 41.000000, longitude: -0.20000), info: "whatever info about london")
        
//        
//        let userlocation = UserLocation(title: "King David Kalakaua",
//                                        locationName: "Waikiki Gateway Park",
//                                        coordinate: CLLocationCoordinate2D(latitude: 45.6782, longitude: 80.9442))
//        
//        
//        let userlocation1 = UserLocation(title: "King David Kalakaua1",
//                                        locationName: "Waikiki Gateway Park1",
//                                        coordinate: CLLocationCoordinate2D(latitude: 40.6782, longitude: 73.9442))
//        
//        mapView.addAnnotations([userlocation,userlocation1])


        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        mapView.showsUserLocation = true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.showsUserLocation = false
    }

    
//    func centerMap(center:CLLocationCoordinate2D){
//        //self.saveCurrentLocation(center)
//        
//        //let spanX = 0.007
//        //let spanY = 0.007
//        
//        //let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
//        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        mapView.setRegion(newRegion, animated: true)
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        
//        centerMap(locValue)
//        locationManager.stopUpdatingLocation();
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "UserPosition"
        
        if annotation is UserPosition
        {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil
            {
                
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                
            }
            else
            {
                annotationView!.annotation = annotation
            }
            
            return annotationView
            
            
        }
        
        return nil

        
    }
    
    
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let userlocation = view.annotation as! UserLocation
//        let placeName = userlocation.title
//        let placeInfo = userlocation.locationName
//        
//        let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//        presentViewController(alertController, animated: true, completion: nil)
//        
//    }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        /// never goes in here, demo only
        
        
        
        
        //var lon = userLocation.coordinate.longitude + 0.1
        //var lat = userLocation.coordinate.latitude + 0.1
        
        //let lon = -73.764278584042628
        //let lat = 40.897627940625505
        
        
        let lon = TRLongitude
        let lat = TRLatitude
        
        let placemark =  MKPlacemark(coordinate: CLLocationCoordinate2DMake(lat, lon), addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        
        let options = [
            MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking,
            MKLaunchOptionsMapTypeKey:MKMapType.Standard.rawValue,
            MKLaunchOptionsShowsTrafficKey:0
        ]
        
        if (isFromDetailView == true)
        {
            isFromDetailView = false
            mapItem.openInMapsWithLaunchOptions(options as? [String : AnyObject])
        }
        
        //        mapView.showsUserLocation = false
        

    }
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
