//
//  TabBarViewController.swift
//  FemFit
//
//  Created by Leila on 5/13/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var launchView : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
         if launchView != nil {
                   launchView!.alpha = 1
               }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
