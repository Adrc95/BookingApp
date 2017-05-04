//
//  Url.swift
//  Booking App
//
//  Created by user126228 on 27/4/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import UIKit

class Url: UIViewController {

    var url:String!
    
    @IBOutlet var vistaWeb: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        cargarPagina(url: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargarPagina(url: String){
        let miURL = URL(string: url)
        let miURLPedido = URLRequest(url: miURL!)
        vistaWeb.loadRequest(miURLPedido)
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
