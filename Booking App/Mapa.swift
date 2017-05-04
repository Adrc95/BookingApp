//
//  Mapa.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit
import MapKit

class Mapa: UIViewController {

    @IBOutlet var mapa: MKMapView!
    var hotel:Hotel!
    var regionRadio: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coordenadas = CLLocationCoordinate2D(latitude: hotel.latitud, longitude: hotel.longitud)
    
        
        let artwork = Artwork(title:hotel.nombre, locationName: hotel.url, discipline: "", coordinate: coordenadas)
        
        centrarMapa(localizacion: coordenadas )
        mapa.addAnnotation(artwork)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centrarMapa(localizacion:CLLocationCoordinate2D){
        let coordenadasRegion = MKCoordinateRegionMakeWithDistance (localizacion, regionRadio + 2.0, regionRadio + 2.0 )
        mapa.setRegion(coordenadasRegion, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
