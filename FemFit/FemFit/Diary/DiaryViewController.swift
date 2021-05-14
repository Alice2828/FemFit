import UIKit
import FirebaseDatabase
import FirebaseAuth
import CoreData

class DiaryViewController: UIViewController{
    var notesCoreList = [NoteRecord]()
    var selectedRecord: NoteRecord?
    @IBOutlet weak var recordsTableView: UITableView!
    override func viewDidLoad() {
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        
        recordsTableView.register(UINib(nibName: "RecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondReusableCell")
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        notesCoreList = loadNotes().reversed()
        recordsTableView.reloadData()
        
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notesCoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "SecondReusableCell", for: indexPath) as! RecordsTableViewCell
        cell.dateLabel.text =  notesCoreList[indexPath.row].date
        cell.caloriesLabel.text = notesCoreList[indexPath.row].cals
        cell.cellView.layer.cornerRadius = 20
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                let context = appDelegate.persistentContainer.viewContext
                context.delete(notesCoreList[indexPath.row])
                notesCoreList.remove(at: indexPath.row)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteRecord")
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
                do {
                    notesCoreList = try context.fetch(fetchRequest) as! [NSManagedObject] as! [NoteRecord]
                } catch let error as NSError {
                    print("Error While Fetching Data From DB: \(error.userInfo)")
                }
            }
            tableView.reloadData()
            // tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecord = notesCoreList[indexPath.row]
        performSegue(withIdentifier: "toEdit", sender: nil)
        //  print(notesCoreList[indexPath.row].ingredients)
        
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
        return notesCoreList
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEdit"){
            let destination = segue.destination as! EditRecordTableVC
            destination.selectedRecord = selectedRecord
        }
    }
}
