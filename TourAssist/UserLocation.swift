//
//  UserLocation.swift
//  TourAssist
//
//  Created by Chee Chong Cheah on 8/4/16.
//  Copyright © 2016 Chee Chong Cheah. All rights reserved.
//

import Foundation
import MapKit

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
