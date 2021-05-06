//
//  DiaryViewController.swift
//  FemFit
//
//  Created by Leila on 4/27/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

protocol AddRecordProtocol {
    func addRecord(record: Record)
}
protocol ChangeRecordProtocol {
    func changeRecord(index: Int, record: Record)
}


class SearchMealViewController: UIViewController {
    var meals: [Meal] = [
        Meal(name: "Chicken breast", grams: 150, calories: 110.0),
        Meal(name: "Rice", grams: 200, calories: 150.9)
    ]
    var currentRecord: Record?
    var currentIndex: Int?
    var cups = 0
    var delegate: AddRecordProtocol?
    var changeDelegate: ChangeRecordProtocol?

    @IBOutlet weak var cup1: UIButton!
    @IBOutlet weak var cup2: UIButton!
    @IBOutlet weak var cup3: UIButton!
    @IBOutlet weak var cup4: UIButton!
    @IBOutlet weak var cup5: UIButton!
    @IBOutlet weak var cup6: UIButton!
    @IBOutlet weak var cup7: UIButton!
    
    @IBAction func cupPressed1(_ sender: Any) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cups = 1
    }
    @IBAction func cupPressed2(_ sender: UIButton) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cups = 2
    }
    @IBAction func cupPressed3(_ sender: UIButton) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cup3.layer.backgroundColor = UIColor.blue.cgColor
        cups = 3
    }
    @IBAction func cupPressed4(_ sender: UIButton) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cup3.layer.backgroundColor = UIColor.blue.cgColor
        cup4.layer.backgroundColor = UIColor.blue.cgColor
        cups = 4
    }
    @IBAction func cupPressed5(_ sender: UIButton) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cup3.layer.backgroundColor = UIColor.blue.cgColor
        cup4.layer.backgroundColor = UIColor.blue.cgColor
        cup5.layer.backgroundColor = UIColor.blue.cgColor
        cups = 5
    }
    @IBAction func cupPressed6(_ sender: Any) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cup3.layer.backgroundColor = UIColor.blue.cgColor
        cup4.layer.backgroundColor = UIColor.blue.cgColor
        cup5.layer.backgroundColor = UIColor.blue.cgColor
        cup6.layer.backgroundColor = UIColor.blue.cgColor
        cups = 6
    }
    @IBAction func cupPressed7(_ sender: Any) {
        cup1.layer.backgroundColor = UIColor.blue.cgColor
        cup2.layer.backgroundColor = UIColor.blue.cgColor
        cup3.layer.backgroundColor = UIColor.blue.cgColor
        cup4.layer.backgroundColor = UIColor.blue.cgColor
        cup5.layer.backgroundColor = UIColor.blue.cgColor
        cup6.layer.backgroundColor = UIColor.blue.cgColor
        cup7.layer.backgroundColor = UIColor.blue.cgColor
        cups = 7
    }
    
    @IBAction func saveRecord(_ sender: UIButton) {
        let newRecord = Record(meals: meals, weight: Int(weightTextField.text!)!, cupsOfWater: cups, date: Date())
        if currentIndex == nil{
            delegate?.addRecord(record: newRecord)
        }else{
            changeDelegate?.changeRecord(index: currentIndex!, record: newRecord)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBAction func MealAdded(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a meal", message: "Describe your meal", preferredStyle: .alert)
        present(alert, animated: true)
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Meal"
        alert.textFields![1].placeholder = "Grams"
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action) in
            let name = alert.textFields![0].text
            let grams = alert.textFields![1].text
            //calculate calories
            self.meals.append(Meal(name: name!, grams: Int(grams!)!, calories: 100.0))
            self.mealsTableView.reloadData()
        }))
    }
    
    
    @IBOutlet weak var mealsTableView: UITableView!
    override func viewDidLoad() {
        if currentRecord != nil{
             meals = currentRecord?.meals as! [Meal]
        }else{
            meals = []
        }
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = false
        weightTextField.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        
        mealsTableView.register(UINib(nibName: "MealsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
extension SearchMealViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MealsTableViewCell
        cell.nameLabel.text = meals[indexPath.row].name
        cell.gramsLabel.text = String(meals[indexPath.row].grams)+" g"
        cell.caloriesLabel.text = String(meals[indexPath.row].calories)+" kcal"
        cell.cellView.layer.cornerRadius = 20
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}
