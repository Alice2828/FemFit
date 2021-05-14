//
//  ProfileViewController.swift
//  FemFit
//
//  Created by User on 02.05.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class ProfileViewController: UIViewController {
    
    //[month: [day]]
    var datesArray: [Int: [Int]] = [:]
    var allDatesArray: [Int: [Int]] = [:]
    var notesCoreList = [NoteRecord]()
    @IBOutlet weak var activityCollectionView: UICollectionView!
    @IBOutlet weak var weightBtn: UIButton!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var periodsBtn: UIButton!
    @IBOutlet weak var pilatesTag: UILabel!
    @IBOutlet weak var weightLossTag: UILabel!
    @IBOutlet weak var cardioLossTag: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        activityCollectionView.delegate = self
        activityCollectionView.dataSource = self
        pilatesTag.layer.masksToBounds = true
        weightLossTag.layer.masksToBounds = true
        cardioLossTag.layer.masksToBounds = true
        pilatesTag.layer.cornerRadius = 10
        weightLossTag.layer.cornerRadius = 10
        weightLossTag.frame.inset(by: UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 10))
        cardioLossTag.layer.cornerRadius = 10
        weightBtn.layer.cornerRadius = 20
        waterBtn.layer.cornerRadius = 20
        periodsBtn.layer.cornerRadius = 20
    }
    override func viewWillAppear(_ animated: Bool) {
        notesCoreList = loadNotes().reversed()
        activityCollectionView.reloadData()
    }
    func loadNotes() -> [NoteRecord] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
            do{
                try notesCoreList = context.fetch(fetchRequest)
            }
            catch{
            }}
        
        for note in notesCoreList{
            let lowerBound = note.date?.index(note.date!.startIndex, offsetBy: 3)
            let upperBound = note.date?.index(note.date!.startIndex, offsetBy: 5)
            let mySubstring = note.date![lowerBound!..<upperBound!]
            if datesArray.index(forKey: Int(String(mySubstring))!) != nil{
                let lowerBound = note.date?.index(note.date!.startIndex, offsetBy: 0)
                let upperBound = note.date?.index(note.date!.startIndex, offsetBy: 2)
                let myDaySubstring = note.date![lowerBound!..<upperBound!]
                datesArray[Int(String(mySubstring))!]?.append(Int(String(myDaySubstring))!)
            }else{
                let lowerBound = note.date?.index(note.date!.startIndex, offsetBy: 0)
                let upperBound = note.date?.index(note.date!.startIndex, offsetBy: 2)
                let myDaySubstring = note.date![lowerBound!..<upperBound!]
                datesArray[Int(String(mySubstring))!] = [Int(String(myDaySubstring))!]
            }
        }
        print(datesArray)
        allDatesArray = [4: [6, 7, 8, 9]]
        
        return notesCoreList
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notesCoreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyActivityCollectionViewCell", for: indexPath) as! DailyActivityCollectionViewCell
        cell.dateLabel.text = String((notesCoreList[indexPath.row].date?.prefix(5))!)
        
        cell.view.layer.cornerRadius = 10
        
        cell.view.layer.backgroundColor = UIColor(named: "Color")?.cgColor
        return cell
    }
}
