//
//  AvailableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/3/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class AvailableViewController: UIViewController,CLLocationManagerDelegate {
    
    var ref: FIRDatabaseReference!
    
    let locationManager = CLLocationManager()
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0


    @IBOutlet weak var segmentAvailable: UISegmentedControl!
    
    
    @IBAction func segmentAvailable_Changed(sender: AnyObject) {
        
        if segmentAvailable.selectedSegmentIndex == 0
        {
            //ref.child("users").child("-KNdgeBhrhhzhMZhoKbY").setValue(["available":true])
            ref.child("users/\(LoginInstance.keyID)/available").setValue(true)
            
            ref.child("users/\(LoginInstance.keyID)/longitude").setValue(longitude)
            
            ref.child("users/\(LoginInstance.keyID)/latitude").setValue(latitude)
            
            var alert = UIAlertController(title: "Availability", message:
                "You are now Available to serve.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: false, completion: nil)

            
        }
        else
        {
            //ref.child("users").child("-KNdgeBhrhhzhMZhoKbY").setValue(["available":false])
            ref.child("users/\(LoginInstance.keyID)/available").setValue(false)
            
            var alert = UIAlertController(title: "Availability", message:
                "You are now Unavailable to serve.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: false, completion: nil)

        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        
        
        ref.child("users").queryOrderedByChild("uid").queryEqualToValue(LoginInstance.keyID).observeEventType(.ChildAdded, withBlock: { snapshot in
            //if let lastname = snapshot.value!["lastname"] as? String {
            //print(lastname)
            let available = snapshot.value!["available"] as? Bool


            if available == true
            {
                self.segmentAvailable.selectedSegmentIndex = 0
            }
            else
            {
                self.segmentAvailable.selectedSegmentIndex = 1
            }
           
            
            
            
        })

        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        longitude = locValue.longitude
        latitude = locValue.latitude
        
        locationManager.stopUpdatingLocation();
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
