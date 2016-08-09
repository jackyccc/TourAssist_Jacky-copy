//
//  TourGuidesDetailViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/30/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI
import CoreLocation

class TourGuidesDetailViewController: UIViewController,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var tourguide:AppUsers!
    //var loginuser:LoginUser!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtViewPhone: UITextView!

    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblName: UILabel!

    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLanguages: UILabel!
    @IBOutlet weak var lblNation: UILabel!
    
    var base64string:NSString!
    
    var ref: FIRDatabaseReference!
    var refAuth: FIRAuth!
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //tourguide = tourguidesDetail(tourguide)
        
        ref = FIRDatabase.database().reference()
        
        self.lblName.text = tourguide.lastname + ", \(tourguide.firstname)"
        
        self.lblNation.text = tourguide.nationality
        
        self.lblEmail.text = tourguide.email
        self.lblSex.text = tourguide.sex
        

        self.txtViewPhone.text = tourguide.phone
        
        self.lblLanguages.text = tourguide.language
        
        base64string = tourguide.imageStr
        
        var decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        var decodedImage = UIImage(data:decodedData!)!
        
        self.imgProfilePic.image = decodedImage
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        longitude = locValue.longitude
        latitude = locValue.latitude

        locationManager.stopUpdatingLocation();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Reserve_Click(sender: AnyObject) {
    
//        if let user = FIRAuth.auth()?.currentUser
//        {
//            let name = user.displayName
//            let email = user.email
//        }
        
        let TGKey = tourguide.key
        

        let TRKey = LoginInstance.keyID
        

        
        
        ref.child("users/\(TGKey)/connected").setValue("\(TRKey)")
        
        ref.child("users/\(TRKey)/longitude").setValue(longitude)
        
        ref.child("users/\(TRKey)/latitude").setValue(latitude)
        
 
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
