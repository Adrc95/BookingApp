//
//  VCMapView.swift
//  AdvanceComponents2
//
//  Created by user125874 on 4/18/17.
//  Copyright © 2017 user125874. All rights reserved.
//

import Foundation
import MapKit

// Tutorial completísimo: https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial

extension ViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton.withType(.detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
