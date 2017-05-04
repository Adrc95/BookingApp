//
//  ViewController.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet var tabla: UITableView!
    
    var imagenesHoteles:[UIImage] = [#imageLiteral(resourceName: "burj-al-arab"),#imageLiteral(resourceName: "hyatt-mallorca"),#imageLiteral(resourceName: "atlantis"),#imageLiteral(resourceName: "president_wilson"),#imageLiteral(resourceName: "palms")]
    
    var listadoReservas:[Reserva] = []
    
    var pdfs = ["burj-al-arab","hyatt-mallorca","atlantis","president_wilson","palms"]
    var usuario:String = "Adrian"
    
    @IBAction func cambiarUsuario(_ sender: UIButton) {
        //Creamos una alerta en la que solicitaremos el id a borrar
        let alerta = UIAlertController(title: "Cambiar Usuario", message: "Nombre del Usuario", preferredStyle: UIAlertControllerStyle.alert)
        
        //Añadimos botones a la alerta
        alerta.addAction(UIAlertAction(title: "Cambiar", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            let textField =  alerta.textFields!.first
            self.usuario = (textField?.text)!
            self.nombreUsuario.text = "Usuario: " + self.usuario
        
        }
        ))
        
        let cancelar = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: { alertAction in
            ()
            alerta.dismiss(animated: true, completion: nil)
        })
        
        //Añadimos un campo para introducir texto y recuperar el id a borrar
        alerta.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Introduce un nuevo usuario"}
        
        alerta.addAction(cancelar)
        
        //Mostramos la alerta en nuestra vista
        self.present(alerta, animated: true, completion: nil)
    }
    
    @IBOutlet var nombreUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.dataSource = self
        tabla.delegate = self
        
        nombreUsuario.text = "Usuario: " + usuario
        Timer.scheduledTimer(timeInterval: 2.0,
                             target: self,
                             selector: #selector(ViewController.cargarReservas),
                             userInfo: nil,
                             repeats: true)
        
        
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
    
    func cargarReservas(){
        listadoReservas.removeAll()
        let key = "reserva"
        let postString = "key=\(key)"//datos enviar post
        
        
        let url = URL(string: "http://adrianapps.16mb.com/ultimasReservas.php")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"//tipo de envio -> metodo post
        request.httpBody = postString.data(using: .utf8)// concatenar mis variables con codificacion utf8
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {//si existe un error se termina la funcion
                print("solicitud fallida \(error)")//manejamos el error
                return //rompemos el bloque de codigo
            }
            
            do {//creamos nuestro objeto json
                
                if let json = try JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                    
                    DispatchQueue.main.async {//proceso principal
                        
                         for result in json {
                            let idReserva:Int = Int(result["idreserva"] as! String)!
                            let idHotel:Int = Int(result["idhotel"] as! String)!
                            let nombre:String = result["nombre"] as! String
                            let fecha:String = result["fecha"] as! String
                            let cantidad:Int = Int(result["hab_cantidad"] as! String)!
                            
                    
                            
                            let reserva = Reserva(idReserva: idReserva, idHotel: idHotel, nombre: nombre, fecha: fecha, hab_cantidad: cantidad)
                         
                         self.listadoReservas.append(reserva)
                         
                         
                         }
                        self.tabla.reloadData()
                    }
                }
                
            } catch let parseError {//manejamos el error
                print("error al parsear: \(parseError)")
                
                let responseString = String(data: data, encoding: .utf8)
                print("respuesta : \(responseString)")
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listadoReservas.count
    }
    
    @IBAction func onClickCatalago(_ sender:
        UIButton) {
         performSegue(withIdentifier: "catalogo", sender: nil)
    }
    @IBAction func onClickMisRerservas(_ sender: UIButton) {
        performSegue(withIdentifier: "reservas", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = UITableViewCell()
        celda.textLabel?.text = listadoReservas[indexPath.row].nombre + " " + listadoReservas[indexPath.row].fecha + " " + String(listadoReservas[indexPath.row].hab_cantidad)
        //celda.detailTextLabel?.text = "Categoria: Deporte"
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "catalogo"){
            let controlador = segue.destination as? TableViewControllerCatalogo
            controlador!.imagenes = imagenesHoteles
            
        }
        else if(segue.identifier == "reservas"){
            let controlador = segue.destination as? TableViewController
            controlador?.nombre = usuario
            controlador?.imagenesHotel = imagenesHoteles
            controlador?.pdfs = pdfs
        }
    }

    
}

