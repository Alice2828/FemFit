//
//  ExerciesViewController.swift
//  FemFitDraft
//
//  Created by Leila on 5/3/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit

class FirstExerciesViewController: UIViewController {
    var rowSelected: Int?
    var buttonsArray = ["Arms", "Legs", "Abdomen", "Neck", "ABS"]
    @IBOutlet weak var buttonTableView: UITableView!
    @IBOutlet weak var dailyGoalsColView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTableView.delegate = self
        buttonTableView.dataSource = self
        

       
    }


}
extension FirstExerciesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciesCollectionViewCell", for: indexPath) as! ExerciesCollectionViewCell
        cell.image.layer.cornerRadius = 10
        cell.view.layer.cornerRadius = 10
        return cell
    }
}
extension FirstExerciesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = buttonTableView.dequeueReusableCell(withIdentifier: "ExerciseButtonTableViewCell", for: indexPath) as! ExerciseButtonTableViewCell
        cell.label.text = buttonsArray[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ExercisesViewController
        destination.categoryID = rowSelected
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        performSegue(withIdentifier: "toExerciseList", sender: self)
        
    }
    
    
}
