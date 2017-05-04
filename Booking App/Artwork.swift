//
//  Artwork.swift
//  Mapa
//
//  Created by user126228 on 4/26/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title:String,locationName:String,discipline:String,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    
    var subTittle: String {
        return locationName
    }
}
