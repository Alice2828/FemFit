
//
//  SecondDiaryViewController.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController{
    
    var notes = [Note]()
    
    @IBOutlet weak var recordsTableView: UITableView!
    override func viewDidLoad() {
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
  
        
        
        
        recordsTableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondReusableCell")
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "SecondReusableCell", for: indexPath) as! RecordsTableViewCell
      //  let date = records[indexPath.row].date
     //   let calendar = Calendar.current
       // let day = calendar.component(.day, from: date)
      //  let month = calendar.component(.month, from: date)
        
       // cell.dateLabel.text = String(day) + "." + String(month)
        cell.caloriesLabel.text = "+100kcal"
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
