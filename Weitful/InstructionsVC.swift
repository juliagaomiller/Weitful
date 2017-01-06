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
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    let context = delegate.persistentContainer.viewContext
    let defaultState = State.exercising
    var currentState: State!
    var eatingArray: [Eating]!
    var exerciseArray: [Exercising]!
    
    override func viewDidLoad() {
        setUp()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        checkIfThereAreAnyEdits()
        
        currentState = defaultState
        changeButtonColors(background: UIColor.black)
        loadInstructionEntitiesFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBAction func questionMark(_ sender: Any) {
        let screenshot = H.takeScreenshot(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: segueID.tutorialVC ) as! TutorialVC
        vc.screenshot = screenshot
        vc.VCTitle = segueID.instructionsVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func back (){
        dismissVC()
    }
    
    func changeButtonColors(background: UIColor){
        revertBtn.backgroundColor = background
        toggleBtn.backgroundColor = background
        backBtn.backgroundColor = background
        var textColor: UIColor!
        if background == UIColor.black {
            textColor = UIColor.white
            //header is white and question mark is black
        } else {
            textColor = UIColor.black
            //header is black and question mark is white
        }
        revertBtn.setTitleColor(textColor, for: .normal)
        toggleBtn.setTitleColor(textColor, for: .normal)
        backBtn.setTitleColor(textColor, for: .normal)
    }
    
    @IBAction func toggle(btn: UIButton){
        if btn.currentTitle == "EATING" {
            currentState = .eating
            btn.setTitle("EXERCISING", for: .normal)
            changeButtonColors(background: UIColor.white)
            tableView.reloadData()
        } else {
            currentState = .exercising
            btn.setTitle("EATING", for: .normal)
            changeButtonColors(background: UIColor.black)
            tableView.reloadData()
        }
    }
    
    func checkIfThereAreAnyEdits(){
        revertBtn.isHidden = true
    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
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
        cell.selectionStyle = .none
        if currentState == .exercising {
            cell.configureCell(exercising: exerciseArray[i])
            self.view.backgroundColor = UIColor.white
        } else {
            cell.configureCell(eating: eatingArray[i])
            self.view.backgroundColor = UIColor.black
        }
        return cell
    }
    
    
    
}
