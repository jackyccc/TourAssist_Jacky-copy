//
//  PrivateTourGuides.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 6/28/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import UIKit
import MapKit

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
    var longitude:Double
    var latitude:Double
    
    init(key:String,lastname:String,firstname:String,email:String,nationality:String,phone:String,imageStr:String, language:String, sex:String, longitude:Double, latitude:Double)
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
        self.longitude = longitude
        self.latitude = latitude
        self.key = key
        
        
    }
    
    //    convenience override init()
    //    {
    //        self.init(lastname:"",firstname:"",email:"",)
    //    }
    
}


class UserPosition: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    //let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        //self.discipline = discipline
        self.coordinate = coordinate
        
        //super.init()
    }
    
    //    var subtitle: String? {
    //        return locationName
    //    }
}



class LoginUser
{
    //var emailID:String
    var keyID:String
    var longitude:Double
    var latitude:Double
//    
//    func getValue() -> String
//    {
//        return emailID
//    }
    
    init(key:String, longitude:Double, latitude:Double)
    {
        //self.emailID = email
        self.keyID = key
        self.longitude = longitude
        self.latitude = latitude
    }
    
    
    
}

var LoginInstance = LoginUser(key:"", longitude: 0,latitude: 0)



//class Picture {
//    
//    var id:Int?
//    var TourGuidesId:Int?
//    
//}