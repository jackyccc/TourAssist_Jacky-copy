//
//  TouristTableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/2/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
//import FirebaseDatabaseUI

class TouristTableViewController: UITableViewController {

    var tourists = [AppUsers]()
    
    var ref: FIRDatabaseReference!
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet var TRTableView: UITableView!

    @IBAction func btnReload_Click(sender: AnyObject) {
        
        tourists.removeAll()
        self.TRTableView.reloadData()
        
        tourists = findTourists()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        
        tourists = findTourists()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func findTourists() -> [AppUsers]
    {
        
        
        
        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        spinnerActivity.label.text = "Loading ...";
        
        //spinnerActivity.detailsLabel.text = "Please Wait!!";
        
        spinnerActivity.userInteractionEnabled = true;
        
        
        
        ref.child("users").queryOrderedByChild("isTourist").queryEqualToValue(true).observeEventType(.ChildAdded, withBlock: { snapshot in
            //if let lastname = snapshot.value!["lastname"] as? String {
            //print(lastname)
            let LName = snapshot.value!["lastname"] as? String
            let FName = snapshot.value!["firstname"] as? String
            let emailAdd = snapshot.value!["email"] as? String
            //let isTourist = snapshot.value!["isTourist"] as? Bool
            let phone = snapshot.value!["phone"] as? String
            let nationality = snapshot.value!["nationality"] as? String
            let language = snapshot.value!["language"] as? String
            let sex = snapshot.value!["sex"] as? String
            let imgStr = snapshot.value!["image"] as? String
            let longitude = snapshot.value!["longitude"] as? Double
            let latitude = snapshot.value!["latitude"] as? Double
            let key = snapshot.value!["uid"] as? String
            
            
            self.tourists.append(AppUsers(key:key!,lastname:LName!, firstname:FName!, email:emailAdd!,nationality:nationality!,phone:phone!,imageStr:imgStr!,language:language!,sex:sex!,longitude:longitude!,latitude:latitude!))
            //}
            
            
            self.TRTableView.reloadData()
            
            spinnerActivity.hideAnimated(true)
            
            
            
        })
        
        
        
        return tourists
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tourists.count
    }
    
    
    var base64string:NSString!
    
    // question: ???
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("subtitle", forIndexPath: indexPath)
        
        let tourist = tourists[indexPath.row]
        
        
        let TRLocation:CLLocation = CLLocation(latitude: tourist.latitude, longitude: tourist.longitude)
        let TGLocation:CLLocation = CLLocation(latitude: LoginInstance.latitude, longitude: LoginInstance.longitude)
        let meters:CLLocationDistance = TRLocation.distanceFromLocation(TGLocation)
        let miles =  String(format: "%.2f", meters/1609)
        
        cell.textLabel?.text = tourist.lastname + ", \(tourist.firstname)"


        
        cell.detailTextLabel?.text = "Distance: \(miles) miles away"
        

        
        //cell.detailTextLabel?.text = "\(tourist.nationality)"
        
        
        base64string = tourist.imageStr
        
        let decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data:decodedData!)!
        
        
        
        
        cell.imageView?.image = imageWithImage(decodedImage, scaledToSize: CGSize(width: 40, height: 40)) //decodedImage
        
        //cell.imageView?.image = resizeImageWithAspect(decodedImage,scaledToMaxWidth: 40.0, maxHeight: 40.0);
        
//        if indexPath.row == tourists.count - 1
//        {
//            //MBProgressHUD.hideAllHUDsForView(self.view, animated: true);
//            
//            //spinnerActivity.hideAnimated(true)
//            //self.dismissViewControllerAnimated(false, completion: nil)
//        }
        
        return cell
    }
    
    
    

    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueTouristDetail"
            
        {
            // Get the new view controller using segue.destinationViewController.
            let controller = segue.destinationViewController as! TouristDetailTableViewController
            
            // Pass the selected object to the new view controller.
            let selectedTR = tourists[tableView.indexPathForSelectedRow!.row]
            
            controller.tourist = selectedTR
        }
        
    }


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
