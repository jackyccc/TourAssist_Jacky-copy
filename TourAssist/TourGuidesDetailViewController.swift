//
//  TourGuidesDetailViewController.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/30/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit

class TourGuidesDetailViewController: UIViewController {

    var tourguide:TourGuides!
    
    @IBOutlet weak var imgProfilePic: UIImageView!

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLanguages: UILabel!
    @IBOutlet weak var lblNation: UILabel!
    
    var base64string:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //tourguide = tourguidesDetail(tourguide)
        
        self.lblName.text = tourguide.lastname + ", \(tourguide.firstname)"
        
        self.lblNation.text = tourguide.nationality
        
        self.lblEmail.text = tourguide.email
        
        self.lblPhone.text = tourguide.phone
        
        self.lblLanguages.text = tourguide.language
        
        base64string = tourguide.imageStr
        
        var decodedData = NSData(base64EncodedString: base64string as String, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        var decodedImage = UIImage(data:decodedData!)!
        
        self.imgProfilePic.image = decodedImage

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
