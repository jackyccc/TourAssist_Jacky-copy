//
//  TouristDetailViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/2/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class TouristDetailViewController: UIViewController {
    
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
    
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.lblName.text = tourist.lastname + ", \(tourist.firstname)"
        
        self.lblNationality.text = tourist.nationality
        
        self.lblEmail.text = tourist.email
        self.lblSex.text = tourist.sex
        
        
        self.txtViewPhone.text = tourist.phone
        
        self.lblLanguage.text = tourist.language
        
        base64string = tourist.imageStr
        
        var decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        var decodedImage = UIImage(data:decodedData!)!
        
        self.imgProfile.image = decodedImage


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
