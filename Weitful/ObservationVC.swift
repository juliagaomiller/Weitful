//
//  ObservationVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/11/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData



class ObservationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerciseBtn: UIButton!
    @IBOutlet weak var eatingBtn: UIButton!
    @IBOutlet weak var neitherBtn: UIButton!
    
    let context = delegate.persistentContainer.viewContext
    let defaultTable: Type = .eating
    var currentTable: Type!
    
    var eatingArray = [Observation]()
    var exerciseArray = [Observation]()
    var neitherArray = [Observation]()
    
    override func viewDidLoad() {
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == segueID.newObservationVC {
            let vc = segue.destination as! NewObservationVC
            vc.type = currentTable
        }
    }
    
    @IBAction func optionSelected(btn: UIButton){
        handleButtonInput(btn: btn) //Either segue or update tableView
    }
    
    func setUp(){
        setTableViewDefaults()
//        addLongPress()
        addSwipe()
        currentTable = defaultTable
        updateObservationArrays()
        reloadTableViewData()
    }
    
    func setTableViewDefaults(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.allowsMultipleSelectionDuringEditing = false //We need false to allow swipe deleting
    }
    
    
}

extension ObservationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnCorrectArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObservationCell") as! ObservationCell
        let array = returnCorrectArray()
        cell.configure(observation: array[indexPath.row])
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let observation = returnCorrectArray()[indexPath.row]
            context.delete(observation)
            delegate.saveContext()
            updateObservationArrays()
            reloadTableViewData()
        }
    }
}
