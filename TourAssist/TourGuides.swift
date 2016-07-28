//
//  PrivateTourGuides.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/28/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit

class TourGuides
{
    //var id:Int
    
    var lastname:String
    var firstname:String
    var email:String
    //var isTourist:Bool
    var nationality:String
    var phone:String
    var language:String
    //var pw:String
    var imageStr:String
    
    init(lastname:String,firstname:String,email:String,nationality:String,phone:String,imageStr:String, language:String)
    {
        //self.id = id
        
        self.lastname = lastname
        self.firstname = firstname
        self.email = email
        //self.isTourist = isTourist
        self.nationality = nationality
        self.phone = phone
        self.language = language
        //self.pw = pw
        self.imageStr = imageStr
        
        
    }
    
    //    convenience override init()
    //    {
    //        self.init(lastname:"",firstname:"",email:"",)
    //    }
    
}


//class Picture {
//    
//    var id:Int?
//    var TourGuidesId:Int?
//    
//}