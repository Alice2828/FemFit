//
//  ViewController.swift
//  FemFit
//
//  Created by User on 20.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
//let session = URLSession.shared
//let url = URL(string: "https://wger.de/api/v2/login")!
class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        let login = loginTF.text
        let password = passwordTF.text
        
        guard let url = URL(string:  "https://wger.de/api/v2/login/") else {return}
        
        var json = [String:Any]()
        json["username"] = login
        json["password"] = password
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                print(response ?? "def")
                print(String(data: data!, encoding: .utf8) ?? "def") //Try this too!
                }.resume()
        }catch{
        }
    }
    
}

