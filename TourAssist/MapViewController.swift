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

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapview: MKMapView!
    var myLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
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
    
    func centerMap(center:CLLocationCoordinate2D){
        self.saveCurrentLocation(center)
        
        let spanX = 0.007
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        mapview.setRegion(newRegion, animated: true)
    }
    
    func saveCurrentLocation(center:CLLocationCoordinate2D){
        let message = "\(center.latitude) , \(center.longitude)"
        print(message)
        //self.lable.text = message
        myLocation = center
    }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
