//
//  WaterViewController.swift
//  FemFit
//
//  Created by Leila on 5/13/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import CoreData

class WaterViewController: UIViewController {

    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var cupsLabel: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    var currentDateObject: NoteRecord?
    override func viewDidLoad() {
        currentDateObject = findCurrentDate()
        super.viewDidLoad()
        cupsLabel.text = "Today you drank "+String(showItToMe())+"cups of water"
        changeImage()
        

    }
    
    @IBAction func waterBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "How many cups of water did you drink today?", message: "Enter a number", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "cups of water"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            //date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = "HH:mm:ss"
            let dateResult = formatter.string(from: date)
            
            let cups = Int((alert?.textFields![0].text)!)
            
            //write in db
            //ISERT HERE DATERESULT
            self.saveCups(date: dateResult, cups: cups!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: true, completion: nil)
        //printing cups of water saved
        
        
    }
    func saveCups(date: String, cups: Int){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
            do{
                let fetchingDate = date
                fetchRequest.predicate = NSPredicate(format: "date == %@", fetchingDate)
                let notesFetched = try context.fetch(fetchRequest)
                if notesFetched.count == 1{
                    let managedObject = notesFetched[0]
                    let newCups = managedObject.water + Int32(cups)
                    managedObject.setValue(newCups, forKey: "water")
                    
                    try context.save()
                    cupsLabel.text = "Today you drank "+String(showItToMe())+"cups of water"
                    changeImage()
                    
                    
                }else if notesFetched.count == 0{
                    if let entity = NSEntityDescription.entity(forEntityName: "NoteRecord", in: context){
                        let note = NSManagedObject(entity: entity, insertInto: context)
                        note.setValue(date, forKey: "date")
                        note.setValue(cups, forKey: "water")
                        let ingredients = Ingredients(ingredients: [IngredientCore]())
                        note.setValue(ingredients, forKey: "ingredients")
                        do{
                            try context.save()
                            cupsLabel.text = "Today you drank "+String(showItToMe())+"cups of water"
                            changeImage()
                            
                        }catch{
                            print("wow i caught the ball")
                        }
                    }
                }else{
                    print("more entities with such a date")
                }
            }
            catch{
            }
        }
    }
    func showItToMe() -> Int{
        return Int(currentDateObject?.water ?? 0)
    }
    func changeImage(){
        let plantCups = currentDateObject?.water ?? 0
                        if plantCups<4{
                            plantImage.image = UIImage(named: "plant1")
                        }else if (plantCups>=4 && plantCups<8){
                            plantImage.image = UIImage(named: "plant2")
                        }else if (plantCups>=8 && plantCups<10){
                            plantImage.image = UIImage(named: "plant3")
                        }else{
                            plantImage.image = UIImage(named: "plant4")
                        }

        
    }
    func findCurrentDate() -> NoteRecord?{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm:ss"
        let dateResult = formatter.string(from: date)
        var noteReturned: NoteRecord?
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
            do{
                let fetchingDate = dateResult
                fetchRequest.predicate = NSPredicate(format: "date == %@", fetchingDate)
                let notesFetched = try context.fetch(fetchRequest)
                if notesFetched.count == 1{
                    noteReturned = notesFetched[0]
                }else{
                }
            }
            catch{
            }
        }
        return noteReturned
        
    }
    

}
