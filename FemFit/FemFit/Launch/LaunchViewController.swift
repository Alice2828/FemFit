//
//  ViewController.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {

    @IBOutlet weak var GetStertedBtn: UIButton!
    @IBOutlet weak var SlidingRect: UIView!
    @IBOutlet weak var Rect1: UIView!
    @IBOutlet weak var Rect3: UIView!
    @IBOutlet weak var Rect2: UIView!
    @IBOutlet weak var Rect4: UIView!
    @IBOutlet weak var WelcomeImage: UIImageView!
    @IBOutlet weak var WelcomeLabel: UILabel!
    var timesSwiped = 0
    
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if currentUser != nil && currentUser!.isEmailVerified{
            self.performSegue(withIdentifier: "toMain", sender: Any?.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0
        navigationController?.navigationBar.barTintColor = UIColor(named: "NavBarColor")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        Rect1.layer.cornerRadius = 5
        Rect2.layer.cornerRadius = 5
        Rect3.layer.cornerRadius = 5
        Rect4.layer.cornerRadius = 5
        SlidingRect.layer.cornerRadius = 5
        SlidingRect.center = Rect1.center
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        timesSwiped += 1
        if timesSwiped == 1{
            UIView.animate(withDuration: 1, animations: {
                self.SlidingRect.center = self.Rect2.center
            })
            WelcomeImage.image = UIImage(named: "SecondWelcomeImage")
            WelcomeLabel.text = "Eat Healthy Everyday"
        }else if timesSwiped == 2{
            UIView.animate(withDuration: 1, animations: {
                self.SlidingRect.center = self.Rect3.center
            })
            WelcomeImage.image = UIImage(named: "ThirdWelcomeImage")
            WelcomeLabel.text = "Get you personal Exercise plan"
            
        }else if timesSwiped == 3{
            UIView.animate(withDuration: 1, animations: {
                self.SlidingRect.center = self.Rect4.center
                self.GetStertedBtn.alpha = 1
            })
            WelcomeImage.image = UIImage(named: "FinalWelcomeImage")
            WelcomeLabel.text = "Start your journey right now!"
            
        }else{
            
        }
        
    }
    
}

