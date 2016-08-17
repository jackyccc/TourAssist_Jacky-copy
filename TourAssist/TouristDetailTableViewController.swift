//
//  TouristDetailTableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/14/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase

class TouristDetailTableViewController: UITableViewController {
    
    var tourist:AppUsers!
    
    var base64string:NSString!
    
    var ref: FIRDatabaseReference!
    var refAuth: FIRAuth!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblSex: UILabel!
    
    @IBOutlet weak var lblNationality: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtViewPhone: UITextView!
    
    @IBOutlet var tableviewTouristDetail: UITableView!
    
    @IBOutlet weak var lblLanguage: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewTouristDetail.allowsSelection = false
        
        tableviewTouristDetail.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.lblName.text = tourist.lastname + ", \(tourist.firstname)"
        
        self.lblNationality.text = tourist.nationality
        
        self.lblEmail.text = tourist.email
        self.lblSex.text = tourist.sex
        
        
        self.txtViewPhone.text = tourist.phone
        
        self.lblLanguage.text = tourist.language
        
        base64string = tourist.imageStr
        
        let decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data:decodedData!)!
        
        self.imgProfile.image = decodedImage

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btnCall_Click(sender: AnyObject) {
        
        callNumber(txtViewPhone.text)
        
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "segueShowNavigation")
        {
            let svc = segue.destinationViewController as! GPSNavigationViewController
            
            svc.TRLongitude = tourist.longitude
            svc.TRLatitude = tourist.latitude
            svc.isFromDetailView = true
        }
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
//
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
