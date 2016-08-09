//
//  MapViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 7/26/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    var ref: FIRDatabaseReference!

    @IBOutlet weak var mapview: MKMapView!
    var myLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapview.delegate = self
        mapview.mapType = .Standard
        mapview.zoomEnabled = true
        mapview.scrollEnabled = true
        
        if let coor = mapview.userLocation.location?.coordinate{
            mapview.setCenterCoordinate(coor, animated: true)
        }
//        
//        let userlocation = UserPosition(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              coordinate: CLLocationCoordinate2D(latitude: -73.764278584042628, longitude: 40.897627940625505))
        
        
        ref.child("users").queryOrderedByChild("available").queryEqualToValue(true).observeEventType(.ChildAdded, withBlock: { snapshot in
            //if let lastname = snapshot.value!["lastname"] as? String {
            //print(lastname)
            let LName = snapshot.value!["lastname"] as? String
            let FName = snapshot.value!["firstname"] as? String
            let lon = snapshot.value!["longitude"] as? Double
            let lat = snapshot.value!["latitude"] as? Double
//            let emailAdd = snapshot.value!["email"] as? String
//            //let isTourist = snapshot.value!["isTourist"] as? Bool
//            let phone = snapshot.value!["phone"] as? String
//            let nationality = snapshot.value!["nationality"] as? String
//            let language = snapshot.value!["language"] as? String
            let sex = snapshot.value!["sex"] as? String
//            let imgStr = snapshot.value!["image"] as? String
//            let key = snapshot.value!["uid"] as? String
            
            let guide = MKPointAnnotation()
            guide.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            guide.title = FName! + " \(LName!)"
            guide.subtitle = sex
            
            
            self.mapview.addAnnotation(guide)
            
        })

        
//        let italy = MKPointAnnotation()
//        italy.coordinate = CLLocationCoordinate2D(latitude: 41.8947400, longitude: 12.4839000)
//        italy.title = "Rome, Italy"
//        
//        let england = MKPointAnnotation()
//        england.coordinate = CLLocationCoordinate2D(latitude: 51.5085300, longitude: -0.1257400)
//        england.title = "London, England"
//        
//        let norway = MKPointAnnotation()
//        norway.coordinate = CLLocationCoordinate2D(latitude: 59.914225, longitude: 10.75256)
//        norway.title = "Oslo, Norway"
//        
//        let spain = MKPointAnnotation()
//        spain.coordinate = CLLocationCoordinate2D(latitude: 40.41694, longitude: -3.70081)
//        spain.title = "Madrid, Spain"
//        
//        let locations = [italy, england, norway, spain]
//        
//        mapview.addAnnotations(locations)
        
        //mapview.addAnnotations(userlocation)
        //mapView.addAnnotations(userlocation)
        
//mapView(MKMapView, viewForAnnotation: userlocation)
        //addLongPressGesture()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        mapview.showsUserLocation = true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapview.showsUserLocation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /*
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(MapViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.mapview.addGestureRecognizer(longPressRecogniser)
    }
    
    func handleLongPress(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .Began{
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.locationInView(self.mapview)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.mapview.convertPoint(touchPoint, toCoordinateFromView: self.mapview)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        
        self.resetTracking()
        self.mapview.addAnnotation(annot)
        self.centerMap(touchMapCoordinate)
    }
    
    func resetTracking(){
        if (mapview.showsUserLocation){
            mapview.showsUserLocation = false
            self.mapview.removeAnnotations(mapview.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
 */
    
    func centerMap(center:CLLocationCoordinate2D){
        self.saveCurrentLocation(center)
        
        //let spanX = 0.007
        //let spanY = 0.007
        
        //let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapview.setRegion(newRegion, animated: true)
    }
    
    func saveCurrentLocation(center:CLLocationCoordinate2D){
        let message = "\(center.latitude) , \(center.longitude)"
        print(message)
        //self.lable.text = message
        myLocation = center
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        centerMap(locValue)
        locationManager.stopUpdatingLocation();
    }
    
//    static var enable:Bool = true
//    @IBAction func getMyLocation(sender: UIButton) {
//        
//        if CLLocationManager.locationServicesEnabled() {
//            if MapViewController.enable {
//                locationManager.stopUpdatingHeading()
//                sender.titleLabel?.text = "Enable"
//            }else{
//                locationManager.startUpdatingLocation()
//                sender.titleLabel?.text = "Disable"
//            }
//            MapViewController.enable = !MapViewController.enable
//        }
//    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
//        let identifier = "pin"
//        var view : MKPinAnnotationView
//        if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
//            dequeueView.annotation = annotation
//            view = dequeueView
//        }else{
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//        }
//        view.pinColor =  .Red
//        return view
//    }
//    
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotation = annotation as? UserLocation {
//            let identifier = "pin"
//            var view: MKPinAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
//                as? MKPinAnnotationView { // 2
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                // 3
//                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
//            }
//            return view
//        }
//        return nil
//    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
