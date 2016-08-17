//
//  TourGuideDetailTableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/14/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class TourGuideDetailTableViewController: UITableViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
    
    var tourguide:AppUsers!
    //var loginuser:LoginUser!
    
    @IBOutlet var tableviewTourguideDetail: UITableView!
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableviewTourguideDetail.allowsSelection = false
        tableviewTourguideDetail.separatorStyle = UITableViewCellSeparatorStyle.None
        
        ref = FIRDatabase.database().reference()
        
        self.lblName.text = tourguide.lastname + ", \(tourguide.firstname)"
        
        self.lblNation.text = tourguide.nationality
        
        self.lblEmail.text = tourguide.email
        self.lblSex.text = tourguide.sex
        
        
        self.txtViewPhone.text = tourguide.phone
        
        self.lblLanguages.text = tourguide.language
        
        base64string = tourguide.imageStr
        
        let decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data:decodedData!)!
        
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

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
