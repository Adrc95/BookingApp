//
//  vistapdf.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class vistapdf: UIViewController {

    var pdf:String!
    @IBOutlet var vistaWeb: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //habilitarZoom()
       mostrarPdf()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func habilitarZoom(){
        vistaWeb.scalesPageToFit = true
    }
    
    func mostrarPdf(){
        
         print("Traza:" + pdf)
        //1: Direccion del archivo pdf
        let direccionPdf = URL(fileURLWithPath: Bundle.main.path(forResource: pdf!, ofType: "pdf", inDirectory: "PDFS")!)
        
        //2:Transformar archivo pdf a Data
        let datosPdf = try? Data(contentsOf: direccionPdf )
        
        //3:Mostrar Datos en el Vista Web
        vistaWeb.load(datosPdf!, mimeType: "application/pdf", textEncodingName: "utf-8", baseURL: direccionPdf)
        
        
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
