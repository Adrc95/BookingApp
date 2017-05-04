//
//  InformacionHotel.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class InformacionHotel: UIViewController {

    @IBOutlet var imagenHotel: UIImageView!
    var hotel:Hotel!
    var fechaReserva:String!
    var pdf:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenHotel.image = hotel.imagen
        nombre.text = hotel.nombre
        direccion.text = hotel.url
        fecha.text = fechaReserva
    }
    @IBOutlet var nombre: UILabel!
    @IBOutlet var fecha: UILabel!
    @IBOutlet var direccion: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickUrl(_ sender: UIButton) {
        performSegue(withIdentifier: "url", sender: nil)    }
    
    @IBAction func onClickMapa(_ sender: UIButton) {
        performSegue(withIdentifier: "mapa", sender: nil)    }
    @IBAction func onClickMasInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "pdf", sender: nil)    }
    @IBAction func onClickInicio(_ sender: UIButton)
    {
        performSegue(withIdentifier: "inicio", sender: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mapa"){
            let controlador = segue.destination as? Mapa
            controlador?.hotel = hotel
        }
        else if(segue.identifier == "url") {
            let controlador = segue.destination as? Url
            controlador?.url = hotel.url
        }
        else if(segue.identifier == "pdf") {
            let controlador = segue.destination as? vistapdf
            controlador?.pdf = pdf
        }
    }
    

}
