//
//  ProfileViewController.swift
//  FemFit
//
//  Created by User on 02.05.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            
        }
        catch{
            print("Error sign out")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
