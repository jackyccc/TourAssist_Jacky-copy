//
//  ViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/9/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseDatabaseUI

class LoginViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    //public var userID:String = ""
    
    var ref: FIRDatabaseReference!
    
    var loginusers = [LoginUser]()

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnForgotPW_Click(sender: AnyObject) {
        
        if (self.txtUsername.text != nil)
        {
        
        FIRAuth.auth()?.sendPasswordResetWithEmail(self.txtUsername.text!, completion: { (error) in
            
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                if error != nil {
                    

                    
                    let alertController = UIAlertController(title: "Error", message: "Unidentified Email Address. Please re-enter the email you have registered with.", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    // Success - Sends recovery email
                    
                    //SVProgressHUD.dismiss()
                    
                    let alertController = UIAlertController(title: "Email Sent", message: "An email has been sent. Please check your email now.", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }})
        }
        else
        {
            let alertController = UIAlertController(title: "", message: "Please enter an Email Address first.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        //locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func logout(sender:UIStoryboardSegue)
    {
        try! FIRAuth.auth()!.signOut()
    }
    

    @IBAction func BacktoLogin(sender:UIStoryboardSegue)
    {
        
    }

       

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        
        
        if identifier == "segueSignin" {
            
            if (txtUsername.text!.isEmpty && txtPassword.text!.isEmpty) {
                
                let alert = UIAlertController(title:"Alert",message: "Please enter the Email and Password.",preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
                
            else {
                
                
                FIRAuth.auth()?.signInWithEmail(txtUsername.text!, password: txtPassword.text!) { (user, error) in
                    if (error != nil)
                    {
                        print (error)
                        
                        let alert = UIAlertController(title:"Alert",message: "Invalid Email or Password",preferredStyle: .Alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        
                        alert.addAction(OKAction)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        
                    }
                    else{
//                        
//                        let alert = UIAlertController(title: nil, message: "Signing In...", preferredStyle: .Alert)
//                        
//                        alert.view.tintColor = UIColor.blackColor()
//                        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
//                        loadingIndicator.hidesWhenStopped = true
//                        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//                        loadingIndicator.startAnimating();
//                        
//                        alert.view.addSubview(loadingIndicator)
//                        self.presentViewController(alert, animated: true, completion: nil)
//                        
                    
                        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
                        
                        spinnerActivity.label.text = "Signing in ...";
                        
                        //spinnerActivity.detailsLabel.text = "Please Wait!!";
                        //spinnerActivity.mode = MBProgressHUDMode.Indeterminate
                        
                        spinnerActivity.userInteractionEnabled = true;
                        
                        
                        let emailadd = self.txtUsername.text!
                        
                        
                        
                        self.ref.child("users").queryOrderedByChild("email").queryEqualToValue(emailadd).observeEventType(.ChildAdded, withBlock: { snapshot in
                            //if let lastname = snapshot.value!["lastname"] as? String {
                            //print(lastname)

                            let isTourist = snapshot.value!["isTourist"] as? Bool
                            let key = snapshot.value!["uid"] as? String

                            //LoginUser(email: self.txtUsername.text!)
                            LoginInstance.keyID = key!
                            
                            
                            
                            
                            //self.dismissViewControllerAnimated(true, completion: nil)
                            
                            
                            
                            if isTourist == true
                            {
                                //loginuser. = self.txtUsername.text!
                                
                                self.performSegueWithIdentifier("segueSignin", sender: nil)
                            }
                            else
                            {
                                self.performSegueWithIdentifier("segueTourguide", sender: nil)
                            }

                            spinnerActivity.hideAnimated(true)
                            
//                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true);
                            
                            
                        })

                        
                        
                        //self.performSegueWithIdentifier("segueSignIn", sender: nil)
                    }
                    
                    
                }
                
            }
            return false
        }
        
        
        return true
        
    }

}

