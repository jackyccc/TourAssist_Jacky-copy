//
//  TourGuidesTableViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/30/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class TourGuidesTableViewController: UITableViewController {
    
    // datasource
    var tourguides = [TourGuides]()
    
    var ref: FIRDatabaseReference!
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet var TGTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the friends list from your API / DB
        ref = FIRDatabase.database().reference()
        
        //LoadingOverlay.shared.showOverlay(self.view)
        

        
        tourguides = findGuides()
        
        
        
        //LoadingOverlay.shared.hideOverlayView()
    }
    
    func findGuides() -> [TourGuides]
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
        
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)
        

        
        ref.child("users").queryOrderedByChild("isTourist").queryEqualToValue(false).observeEventType(.ChildAdded, withBlock: { snapshot in
            //if let lastname = snapshot.value!["lastname"] as? String {
            //print(lastname)
            let LName = snapshot.value!["lastname"] as? String
            let FName = snapshot.value!["firstname"] as? String
            let emailAdd = snapshot.value!["email"] as? String
            //let isTourist = snapshot.value!["isTourist"] as? Bool
            let phone = snapshot.value!["phone"] as? String
            let nationality = snapshot.value!["nationality"] as? String
            let language = snapshot.value!["language"] as? String
            
            let imgStr = snapshot.value!["image"] as? String
            //let pw = snapshot.value!["pw"] as? String
            
            
            self.tourguides.append(TourGuides(lastname:LName!, firstname:FName!, email:emailAdd!,nationality:nationality!,phone:phone!,imageStr:imgStr!,language:language!))
            //}
            
            self.TGTableView.reloadData()
            
            
            
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
        
        cell.textLabel?.text = tourguide.lastname + ", \(tourguide.firstname)"
        cell.detailTextLabel?.text = "\(tourguide.nationality)"
        
        
        base64string = tourguide.imageStr
        
        var decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        var decodedImage = UIImage(data:decodedData!)!

        
        cell.imageView?.image = decodedImage
        
        if indexPath.row == tourguides.count - 1
        {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        
        return cell
    }
    
    
   
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segTourGuidesDetail"
        
        {
            // Get the new view controller using segue.destinationViewController.
            let controller = segue.destinationViewController as! TourGuidesDetailViewController
            
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
