//
//  RegistrationViewController.swift
//  FemFit
//
//  Created by User on 02.05.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func register(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        let name = nameField.text
        let surname = surnameField.text
        indicator.startAnimating()
        if email != "" && password != "" {
            Auth.auth().createUser(withEmail: email!, password: password!)
            {[weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil{
                    self?.showMessage(title: "Success", message: "Please verify your email")
                    let userTable = Database.database(url: "https://femfit-f5c0c-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users").child((Auth.auth().currentUser?.uid)!)
                    let user = UserCustom(email!, (Auth.auth().currentUser?.uid)!, "", name!,surname!)
                    userTable.setValue(user.dict)
                  
                }
                else{
                    self?.showMessage(title: "Error", message: "Some problem occured")
                }
            }
        }
    }
    func showMessage(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default){
            (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
