//
//  ViewController.swift
//  FemFit
//
//  Created by User on 20.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToRegisterPage))
        goToRegister.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var goToRegister: UILabel!
    
    @IBAction func logIn(_ sender: UIButton) {
        //get login and password from textfields
        let email = loginTF.text
        let password = passwordTF.text
        indicator.startAnimating()
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email!, password: password!){
                [weak self]  (result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        self?.performSegue(withIdentifier: "loginToMain", sender: Any?.self)
                    }
                    else{
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                        self?.indicator.stopAnimating()
                    }
                }
                else
                {
                    self?.indicator.stopAnimating()
                }
            }
        }
        else
        {
            self.indicator.stopAnimating()
        }
        
    }
    func showMessage(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func goToRegisterPage(){
        performSegue(withIdentifier: "toRegister", sender: Any?.self)
    }
}

