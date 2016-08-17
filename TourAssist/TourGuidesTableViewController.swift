//
//  TourGuidesTableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/30/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
//import FirebaseDatabaseUI

class TourGuidesTableViewController: UITableViewController {
    
    // datasource
    var tourguides = [AppUsers]()
    
    var ref: FIRDatabaseReference!
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet var TGTableView: UITableView!
    
    @IBAction func btnRefresh_Click(sender: AnyObject) {
        
        tourguides.removeAll()
        
        self.TGTableView.reloadData()
        
        tourguides = findGuides()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the friends list from your API / DB
        ref = FIRDatabase.database().reference()
        
        //LoadingOverlay.shared.showOverlay(self.view)
        

        
        tourguides = findGuides()
        
        
        
        //LoadingOverlay.shared.hideOverlayView()
    }
    
    func findGuides() -> [AppUsers]
    {
    
//            
//        ref.child("users").observeEventType(.ChildAdded, withBlock: { snapshot in
//            //if let lastname = snapshot.value!["lastname"] as? String {
//            //print(lastname)
//            let LName = snapshot.value!["lastname"] as? String
//            let FName = snapshot.value!["firstname"] as? String
//            let emailAdd = snapshot.value!["email"] as? String
//            let isTourist = snapshot.value!["isTourist"] as? Bool
//            let phone = snapshot.value!["phone"] as? String
//            let nationality = snapshot.value!["nationality"] as? String
//            let language = snapshot.value!["language"] as? String
//
//            let imgStr = snapshot.value!["image"] as? String
//            //let pw = snapshot.value!["pw"] as? String
//            
//            
//            self.tourguides.append(TourGuides(lastname:LName!, firstname:FName!, email:emailAdd!, isTourist: isTourist!,nationality:nationality!,phone:phone!,imageStr:imgStr!,language:language!))
//            //}
//            
//            self.TGTableView.reloadData()
//            
//        })
        
        //LoadingOverlay.shared.showOverlay(self.view)
        
//        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .Alert)
//        
//        alert.view.tintColor = UIColor.blackColor()
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        loadingIndicator.startAnimating();
//        
//        alert.view.addSubview(loadingIndicator)
//        presentViewController(alert, animated: true, completion: nil)
        
        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        
        spinnerActivity.label.text = "Loading ...";
        
        //spinnerActivity.detailsLabel.text = "Please Wait!!";
        
        spinnerActivity.userInteractionEnabled = true;
        

        
        ref.child("users").queryOrderedByChild("available").queryEqualToValue(true).observeEventType(.ChildAdded, withBlock: { snapshot in
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
            
            
            self.tourguides.append(AppUsers(key:key!,lastname:LName!, firstname:FName!, email:emailAdd!,nationality:nationality!,phone:phone!,imageStr:imgStr!,language:language!,sex:sex!, longitude:longitude!, latitude:latitude!))
            //}
            
            self.TGTableView.reloadData()
            
            spinnerActivity.hideAnimated(true)
            
        })

        
        
        return tourguides
        
        
        
        
    }

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tourguides.count
    }
    
    var base64string:NSString!
    
    // question: ???
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("subtitle", forIndexPath: indexPath)
        
        let tourguide = tourguides[indexPath.row]
        
        let TGLocation:CLLocation = CLLocation(latitude: tourguide.latitude, longitude: tourguide.longitude)
        let TRLocation:CLLocation = CLLocation(latitude: LoginInstance.latitude, longitude: LoginInstance.longitude)
        let meters:CLLocationDistance = TRLocation.distanceFromLocation(TGLocation)
        let miles =  String(format: "%.2f", meters/1609)

        
        cell.textLabel?.text = tourguide.lastname + ", \(tourguide.firstname)"
        //cell.detailTextLabel?.text = "\(tourguide.nationality)"
        
        cell.detailTextLabel?.text = "Distance: \(miles) miles away"
        
        
        base64string = tourguide.imageStr
        
        let decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data:decodedData!)!

        
        cell.imageView?.image = decodedImage
        
//        if indexPath.row == tourguides.count - 1
//        {
//            //MBProgressHUD.hideAllHUDsForView(self.view, animated: true);
//            //self.dismissViewControllerAnimated(false, completion: nil)
//        }
        
        return cell
    }
    
    
   
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segTourGuidesDetail"
        
        {
            // Get the new view controller using segue.destinationViewController.
            let controller = segue.destinationViewController as! TourGuideDetailTableViewController
            
            // Pass the selected object to the new view controller.
            let selectedTG = tourguides[tableView.indexPathForSelectedRow!.row]
            controller.tourguide = selectedTG
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
