//
//  PrivateTourGuides.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/28/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit

class AppUsers
{
    //var id:Int
    
    var key:String
    var lastname:String
    var firstname:String
    var email:String
    //var isTourist:Bool
    var nationality:String
    var phone:String
    var language:String
    var sex:String
    var imageStr:String
    
    init(key:String,lastname:String,firstname:String,email:String,nationality:String,phone:String,imageStr:String, language:String, sex:String)
    {
        //self.id = id
        
        self.lastname = lastname
        self.firstname = firstname
        self.email = email
        //self.isTourist = isTourist
        self.nationality = nationality
        self.phone = phone
        self.language = language
        self.sex = sex
        self.imageStr = imageStr
        self.key = key
        
        
    }
    
    //    convenience override init()
    //    {
    //        self.init(lastname:"",firstname:"",email:"",)
    //    }
    
}



class LoginUser
{
    //var emailID:String
    var keyID:String
//    
//    func getValue() -> String
//    {
//        return emailID
//    }
    
    init(key:String)
    {
        //self.emailID = email
        self.keyID = key
    }
    
    
    
}

var LoginInstance = LoginUser(key:"")



//class Picture {
//    
//    var id:Int?
//    var TourGuidesId:Int?
//    
//}