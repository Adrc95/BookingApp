//
//  reservar.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class reservar: UIViewController {

    var hotelActual:Hotel!
    
    @IBOutlet var habitaciones: UITextField!
    @IBOutlet var fecha: UITextField!
    @IBOutlet var nombre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onClickReservar(_ sender: UIButton) {
        //Revisamos si los TextFields están vacíos
        if (nombre.text==""){
            mostrarAlerta(titulo:"Faltan Datos", texto: "Falta de escribir el Nombre")
        } else {
            if (fecha.text==""){
                mostrarAlerta(titulo:"Faltan Datos", texto: "Falta de escribir la fecha")
            } else {
                if (habitaciones.text==""){
                    mostrarAlerta(titulo:"Faltan Datos", texto: "Falta de escribir el numero de habitaciones")
                } else {
                    if (hotelActual.hab_libres < Int(habitaciones.text!)!){
                         mostrarAlerta(titulo:"Error", texto: "No hay tantas habitaciones disponibles")
                    }
                    else {
                        realizarReserva(nombre: nombre.text!, fecha: fecha.text!, cantidad: habitaciones.text!)
                        performSegue(withIdentifier: "inicio", sender: nil)
                    }
                }
            }
        }
    }
    
   
    
    func realizarReserva(nombre:String,fecha:String,cantidad:String){
        let request = NSMutableURLRequest(url: NSURL(string: "http://adrianapps.16mb.com/realizarReserva.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "a=\(hotelActual.idHotel)&b=\(nombre)&c=\(fecha)&d=\(cantidad)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
   
    func mostrarAlerta (titulo:String, texto: String ){
        //Creamos una alerta
        let alerta = UIAlertController(title: titulo, message: texto, preferredStyle: UIAlertControllerStyle.alert)
        
        let volver = UIAlertAction(title: "Volver", style: UIAlertActionStyle.default, handler: { alertAction in
            ()
            alerta.dismiss(animated: true, completion: nil)
        })
        
        alerta.addAction(volver)
        
        //Mostramos la alerta en nuestra vista
        self.present(alerta, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
