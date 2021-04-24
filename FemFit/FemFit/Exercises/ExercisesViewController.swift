//
//  ExercisesViewController.swift
//  FemFit
//
//  Created by User on 24.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
var endpoint = "exercise/"
var exercisesList = [Exercise]()

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var exTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExercisesCell
        cell?.nameLabel.text = exercisesList[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exTableView.rowHeight = 150
        guard let url =  URL(string: (urlString + endpoint)) else {return}
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
            
            }.resume()
        
    }
    
}
