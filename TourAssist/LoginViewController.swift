//
//  ViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/9/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
//import CoreLocation
import Firebase

class LoginViewController: UIViewController {
    
    //let locationManager = CLLocationManager()

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignInClick(sender: AnyObject) {
        
    }
    
    @IBAction func logout(sender:UIStoryboardSegue)
    {
        try! FIRAuth.auth()!.signOut()
    }

    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        
        
        if identifier == "segueSignIn" {
            
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
                        self.performSegueWithIdentifier("segueSignIn", sender: nil)
                    }
                    
                    
                }
                
            }
            return false
        }
        
        
        return true
        
    }

}

