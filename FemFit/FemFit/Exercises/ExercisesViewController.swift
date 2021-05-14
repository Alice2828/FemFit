//
//  ExercisesViewController.swift
//  FemFit
//
//  Created by User on 24.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import CoreData
var endpoint = "exercise/"
//var exercisesList = [Exercise]()
var favExercisesList = [Exercise]()

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var exTableView: UITableView!
    var categoryID: Int?
    var exercisesByCategory = [Exercise]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesByCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExercisesCell
        
            cell!.nameLabel.text = exercisesByCategory[indexPath.row].name
            cell!.descriptionLabel.text = exercisesByCategory[indexPath.row].description
        cell!.exerciseIndex = exercisesByCategory[indexPath.row].id
            cell!.authorLabel.text = exercisesByCategory[indexPath.row].license_author
        
        return cell!
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesList = [Exercise(id: 1, uuid: "h", name: "Push ups", status: "j", description: "do", creation_date: "h", category: 2, muscles: [2,3], muscles_secondary: [2,3], equipment: [2,3], language: 2, license: 2, license_author: "j", variations: [2,3]),
        Exercise(id: 2, uuid: "h", name: "Push downs", status: "j", description: "do", creation_date: "h", category: 2, muscles: [2,3], muscles_secondary: [2,3], equipment: [2,3], language: 2, license: 2, license_author: "j", variations: [2,3]),
        Exercise(id: 3, uuid: "h", name: "Push keks", status: "j", description: "do", creation_date: "h", category: 2, muscles: [2,3], muscles_secondary: [2,3], equipment: [2,3], language: 2, license: 2, license_author: "j", variations: [2,3]),
        Exercise(id: 4, uuid: "h", name: "Push one", status: "j", description: "do", creation_date: "h", category: 1, muscles: [2,3], muscles_secondary: [2,3], equipment: [2,3], language: 2, license: 2, license_author: "j", variations: [2,3])]
        for i in 0...exercisesList.count-1{
            if exercisesList[i].category == categoryID{
                exercisesByCategory.append(exercisesList[i])
            }
           // delete
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
//                   let context = appDelegate.persistentContainer.viewContext
//                          let myPersistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
//
//                            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NoteRecord")
//                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            
//                            do {
//                                try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
//                            } catch {}
//            }
        }
        /*guard let url =  URL(string: (urlString + endpoint)) else {return}
        //try make get request
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response ?? "def")
            print(String(data: data!, encoding: .utf8) ?? "def")
            
            do {
                let decoder = JSONDecoder()
                let exerciseResponse = try decoder.decode(ExerciseResponse.self, from:
                    data!) //Decode JSON Response Data
                print(exerciseResponse.results![0].uuid ?? "default")
                exercisesList = exerciseResponse.results!
                DispatchQueue.main.async {
                    self.exTableView.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
            
            }.resume()*/
        
    }
    
}
