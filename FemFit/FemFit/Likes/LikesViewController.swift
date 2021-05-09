//
//  LikesViewController.swift
//  FemFit
//
//  Created by Leila on 5/3/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit


class LikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

   @IBOutlet weak var exTableView: UITableView!
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favExercisesList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExercisesCell
         cell?.nameLabel.text = favExercisesList[indexPath.row].name
         cell?.descriptionLabel.text = favExercisesList[indexPath.row].description
        cell?.exerciseIndex = exercisesList[indexPath.row].id
         cell?.authorLabel.text = favExercisesList[indexPath.row].license_author
         //cell?.layer.cornerRadius = 20
         return cell!
     }
     
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
         
         
     }
    override func viewWillAppear(_ animated: Bool) {
        exTableView.reloadData()
    }


}
