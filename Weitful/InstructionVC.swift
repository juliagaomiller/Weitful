import Foundation
import UIKit
import CoreData

enum State {
    case eating
    case exercising
}

class InstructionsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var revertBtn: UIButton!
    
    let context = delegate.persistentContainer.viewContext
    let defaultState = State.exercising
    var currentState: State!
    var eatingArray: [Eating]!
    var exerciseArray: [Exercising]!
    
    @IBAction func toggle(btn: UIButton){
//        let sections = NSIndexSet(index: 0)
        if btn.currentTitle == "EATING" {
            currentState = .eating
            btn.setTitle("EXERCISING", for: .normal)
            tableView.reloadData()
//            tableView.reloadSections(sections as IndexSet, with: .middle)
            
        } else {
            currentState = .exercising
            btn.setTitle("EATING", for: .normal)
            tableView.reloadData()
        
        }
    }
    
    func checkIfThereAreAnyEdits(){
        revertBtn.isHidden = true
    }
    
    override func viewDidLoad() {
        
        setUp()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        checkIfThereAreAnyEdits()
        
        currentState = defaultState
        loadInstructionEntitiesFromDB()
//        for x in eatingArray {
//            print(x.defaultText!)
//        }
//        for x in exerciseArray {
//            print(x.defaultText!)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
//    func segueToMenuVC(){
//        self.dismiss(animated: true, completion: nil)
//    }

    

}

extension InstructionsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentState == .exercising {
            return exerciseArray.count
        } else {
            return eatingArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell") as! InstructionCell
        if currentState == .exercising {
            cell.configureCell(exercising: exerciseArray[i])
        } else {
            cell.configureCell(eating: eatingArray[i])
        }
        return cell
    }
    
    
    
}
