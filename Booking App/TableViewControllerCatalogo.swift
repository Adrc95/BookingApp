//
//  TableViewControllerCatalogo.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class TableViewControllerCatalogo: UITableViewController {
    
    var listadoHoteles:[Hotel] = []
    var imagenes:[UIImage]  = []
    var indiceSeleccionado:Int = 0
    
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 5.0,
                             target: self,
                             selector: #selector(TableViewControllerCatalogo.cargarHoteles),
                             userInfo: nil,
                             repeats: true)
       
    }
    
    func cargarHoteles(){
        listadoHoteles.removeAll()
        let key = "hotel"
        let postString = "key=\(key)"//datos enviar post
        
        
        let url = URL(string: "http://adrianapps.16mb.com/prueba.php")!
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
                        /*
                         for result in json {
                         let id = result["idhotel"] as! Int
                         let nombre = result["nombre"] as! String
                         let url = result["url"] as! String
                         let latitud = result["latitud"] as! Double
                         let longitud = result["longitud"] as! Double
                         let hab_totales = result["hab_totales"] as! Int
                         let hab_libres = result["hab_libres"] as! Int
                         let imagenHotel:UIImage = self.imagenes[0]
                         
                         let hotel:Hotel = Hotel(idHotel: 0, nombre: nombre, url: url, latitud: latitud, longitud: longitud, hab_totales: hab_totales, hab_libres: hab_libres, imagen: imagenHotel)
                         self.listadoHoteles.append(hotel)
                         
                         
                         }
                         */
                        for i in 0 ..< json.count{
                            
                            //Obtiene los datos
                            let id:Int = Int(json[i]["idhotel"] as! String!)!
                            let nombre:String = json[i]["nombre"] as! String!
                            let url:String = json[i]["url"] as! String!
                            let latitud:Double = Double(json[i]["latitud"] as! String!)!
                            let longitud:Double = Double(json[i]["longitud"] as! String!)!
                            let hab_totales:Int = Int(json[i]["hab_totales"] as! String!)!
                            let hab_libres:Int = Int(json[i]["hab_libres"] as! String!)!
                            
                            let imagenHotel = self.imagenes[i]
                            
                            let hotel = Hotel(idHotel: id, nombre: nombre, url: url, latitud: latitud, longitud: longitud, hab_totales: hab_totales, hab_libres: hab_libres, imagen: imagenHotel)
                            
                            
                            self.listadoHoteles.append(hotel)
                            
                            
                            
                        }
                        self.tableView.reloadData()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listadoHoteles.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)

        cell.textLabel?.text = self.listadoHoteles[indexPath.row].nombre
        cell.imageView?.image = self.listadoHoteles[indexPath.row].imagen
       
        if(listadoHoteles[indexPath.row].hab_libres == 0){
            cell.detailTextLabel?.text = "No quedan habitaciones para reservar"
        }
        else {
             cell.detailTextLabel?.text = "Quedan " + String(self.listadoHoteles[indexPath.row].hab_libres)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indiceSeleccionado = indexPath.row
        if(listadoHoteles[indexPath.row].hab_libres > 0){
            performSegue(withIdentifier: "hacerReserva", sender: nil)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "hacerReserva"){
            let controlador = segue.destination as? reservar
            controlador?.hotelActual = listadoHoteles[indiceSeleccionado]
        }
    }
    

}
