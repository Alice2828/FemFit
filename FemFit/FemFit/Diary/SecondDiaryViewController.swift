
//
//  SecondDiaryViewController.swift
//  FemFitDraft
//
//  Created by Leila on 4/26/21.
//  Copyright © 2021 Leila. All rights reserved.
//

import UIKit

class SecondDiaryViewController: UIViewController, AddRecordProtocol, ChangeRecordProtocol {
    func changeRecord(index: Int, record: Record) {
       // records[index] = record
        recordsTableView.reloadData()
    }
    
    func addRecord(record: Record) {
      //  records.append(record)
        recordsTableView.reloadData()
    }
    
    var records = [ MealsFull]()
    
    @IBOutlet weak var recordsTableView: UITableView!
    override func viewDidLoad() {
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        guard let url =  URL(string: (urlString + "nutritionplaninfo")) else {return}
        //try make get request
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response ?? "def")
            print(String(data: data!, encoding: .utf8) ?? "def")
            
            do {
                let decoder = JSONDecoder()
                let nutritionPlanResponse = try decoder.decode(NutritionPlanResponse.self, from:
                    data!) //Decode JSON Response Data
             //   print(nutritionPlanResponse)
                let nutritionPlans = nutritionPlanResponse.results
                self.records = nutritionPlans[0].meals!
                DispatchQueue.main.async {
                    self.recordsTableView.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
            
            }.resume()
  
        recordsTableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondReusableCell")
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DiaryViewController
        
        if segue.identifier == "toAddRecord"{
            destination.delegate = self
            
            
        }else if segue.identifier == "toEditRecord"{
            destination.changeDelegate = self
            destination.currentIndex = recordsTableView.indexPathForSelectedRow!.row
            
        }
    }
    
}

extension SecondDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
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
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEditRecord", sender: nil)
    }
    
}
