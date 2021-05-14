//
//  WeightViewController.swift
//  FemFit
//
//  Created by Leila on 5/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import CoreData
import Charts

class WeightViewController: UIViewController, IAxisValueFormatter {
    var weightCoreList: [Double]?
    var dateCoreList: [String]?
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.rightAxis.enabled = false
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        lineChartView.xAxis.axisMinLabels = 1
        
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1.0
        
        lineChartView.animate(xAxisDuration: 0.5)
        //get from coredata
        loadWeights()
        loadEntries()
        
    }
    
    @IBAction func addWeight(_ sender: UIButton) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add weight", message: "Enter a number", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "kg"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            //date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            let dateResult = formatter.string(from: date)
            
            //get gramms
            let kg = Int((alert?.textFields![0].text)!)
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            self.saveWeight(date: dateResult, kg: kg!)
            self.loadEntries()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveWeight(date: String, kg: Int){
        //check if there's a current date record
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
            do{
                let fetchingDate = date
                fetchRequest.predicate = NSPredicate(format: "date == %@", fetchingDate)
                let notesFetched = try context.fetch(fetchRequest)
                if notesFetched.count == 1{
                    let managedObject = notesFetched[0]
                    managedObject.setValue(kg, forKey: "weight")
                    
                    try context.save()
                    
                }else if notesFetched.count == 0{
                    if let entity = NSEntityDescription.entity(forEntityName: "NoteRecord", in: context){
                        let note = NSManagedObject(entity: entity, insertInto: context)
                        note.setValue(date, forKey: "date")
                        note.setValue(kg, forKey: "weight")
                        let ingredients = Ingredients(ingredients: [IngredientCore]())
                        note.setValue(ingredients, forKey: "ingredients")
                        do{
                            try context.save()
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
    func loadWeights(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NoteRecord>(entityName: "NoteRecord")
            var notesCoreList = [NoteRecord]()
            do{
                try notesCoreList = context.fetch(fetchRequest)
                weightCoreList = notesCoreList.filter{ note in
                    note.weight != 0
                }.compactMap{ note in
                    return note.weight
                }
                dateCoreList = notesCoreList.compactMap{ note in
                    return note.date
                }
            }
            catch{
            }}
    }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateCoreList![Int(value)]
    }
    func loadEntries(){
        loadWeights()
        //graph
        var dataEntries: [ChartDataEntry] = []
        lineChartView.xAxis.valueFormatter = self
        
        for i in 0..<weightCoreList!.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(weightCoreList![i]))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineWidth = 3
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        // Do any additional setup after loading the view.
    }
}
