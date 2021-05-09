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
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData = [Ingredient]()
    var currentRecord: Record?
    var currentIndex: Int?
    var cups = 0
    var delegate: AddRecordProtocol?
    var changeDelegate: ChangeRecordProtocol?
    
    @IBOutlet weak var mealsTableView: UITableView!
    override func viewDidLoad() {
        searchBar.delegate = self
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        super.viewDidLoad()
        
        guard let url =  URL(string: (urlString + ingredientPath + "?limit=500"+"&language=2")) else {return}
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
                let mealsResponse = try decoder.decode(IngredientsResponse.self, from:
                    data!) //Decode JSON Response Data
                mealsList = mealsResponse.results!
                self.filteredData = mealsList
                DispatchQueue.main.async {
                    self.mealsTableView.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
            
            }.resume()
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //  view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
extension SearchMealViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsTableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath)
        cell.textLabel!.text = filteredData[indexPath.row].name
        cell.detailTextLabel!.text = filteredData[indexPath.row].protein
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenIngredient = filteredData[indexPath.row]
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add ingredient", message: "Enter a number", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "gramms"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            //date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = "HH:mm:ss"
            let dateResult = formatter.string(from: date)
            let timeResult = formatterTime.string(from: date)
            //get gramms
            let gramms = Int((alert?.textFields![0].text)!)
            let  kcal = String(chosenIngredient.energy! * gramms!/100)
            //write in db

//            let randomId = Database.database(url: "https://femfit-f5c0c-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users").child((Auth.auth().currentUser?.uid)!).child("diary").child("notes").child(dateResult)
//
//            let note = Note(dateResult, kcal)
//            randomId.updateChildValues(note.dict)
//            let ingredient = Database.database(url: "https://femfit-f5c0c-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users").child((Auth.auth().currentUser?.uid)!).child("diary").child("notes").child(dateResult).child("ingredients").child(timeResult)
//            ingredient.setValue(chosenIngredient.id)
            
        }))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? mealsList : mealsList.filter { (item: Ingredient) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        mealsTableView.reloadData()
    }
}
