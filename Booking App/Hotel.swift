//
//  Hotel.swift
//  Booking App
//
//  Created by user126228 on 29/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import Foundation
import UIKit

class Hotel {
    
    let idHotel:Int
    let nombre:String
    let url:String
    let latitud:Double
    let longitud:Double
    let hab_totales:Int
    let hab_libres:Int
    let imagen:UIImage!
    
    init(idHotel:Int,nombre:String,url:String,latitud:Double,longitud:Double,hab_totales:Int,hab_libres:Int,imagen:UIImage){
        self.idHotel = idHotel
        self.nombre = nombre
        self.url = url
        self.latitud = latitud
        self.longitud = longitud
        self.hab_totales = hab_totales
        self.hab_libres = hab_libres
        self.imagen = imagen
    }
}
