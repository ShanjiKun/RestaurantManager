//
//  ViewController.swift
//  RestaurantManager
//
//  Created by Vinh Huynh on 7/10/17.
//  Copyright © 2017 Vinh Huynh. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    var socket:SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = SocketIOClient(socketURL: URL(string: "http://192.168.0.102:8080")!, config: [.log(true), .compress])
        socket.connect()
    }
    
    @IBAction func onButtonTapped(_ sender: UIButton) {
        socket.emit("join", "hello")
        socket.on("joined") { (data, ack) in
            
            guard data[0] is [String: String] else{
                return
            }
            
            let dict = data[0] as! [String: String]
            guard let name = dict["name"] else {
                return
            }
            
            print("your name is " + name)
        }
    }
}

