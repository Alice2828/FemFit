
//
//  SecondDiaryViewController.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DiaryViewController: UIViewController{
    
    @IBOutlet weak var recordsTableView: UITableView!
    override func viewDidLoad() {
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        
        recordsTableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondReusableCell")
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        //date
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy"
//        let dateResult = formatter.string(from: date)
        //observe notes
//        let parent = Database.database(url: "https://femfit-f5c0c-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users").child((Auth.auth().currentUser?.uid)!).child("diary").child("notes").child(dateResult)
//        parent.observe(.value){
//            [weak self](snapshot) in
//            notes.removeAll()
//            let snapshotValue = snapshot.value as! [String: String]
//            let note = Note(snapshotValue["date"]! , snapshotValue["totalCkal"]!)
//            notes.reverse()
//            self?.recordsTableView.reloadData()
       // }
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "SecondReusableCell", for: indexPath) as! RecordsTableViewCell
        cell.dateLabel.text =  notes[indexPath.row].date
        cell.caloriesLabel.text = notes[indexPath.row].totalCkal
        cell.cellView.layer.cornerRadius = 20
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEditRecord", sender: nil)
    }
}
