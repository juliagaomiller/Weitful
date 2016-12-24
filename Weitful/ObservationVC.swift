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
    @IBOutlet weak var clearDone: UIStackView!
    @IBOutlet weak var newObservTV: UITextView!
    @IBOutlet weak var TVborder: UIView!
    
    let offscreenRight = OffScreenRightAC()
    
    let context = delegate.persistentContainer.viewContext
    var observations = [Observation]()
    var comments = [ObservationComments]()
    
    //var indexPathForSelectedRow: Int?
    
    override func viewDidLoad() {
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == segueID.commentsVC{
            guard let indexPath = tableView.indexPathForSelectedRow else {fatalError()}
            let vc = segue.destination as! CommentsVC
            vc.observation = observations[indexPath.row]
            vc.transitioningDelegate = self
        }
    }
    
    @IBAction func clear(){
        newObservTV.text = ""
    }
    
    @IBAction func done(){
        if newObservTV.text != "" {
            let _ = Observation(text: newObservTV.text, rank: observations.count, context: context)
            delegate.saveContext()
        }
        animateNewObservationView(isActivated: false)
        reloadTableViewData()
    }
    
    @IBAction func newObservation(){
        animateNewObservationView(isActivated: true)
    }

    func setUp(){
        hideNewObservationView()
        setTableViewDefaults()
        addSwipe()
        reloadTableViewData()
    }
    
    func setTableViewDefaults(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100
        tableView.allowsMultipleSelectionDuringEditing = false //We need false to allow swipe deleting
    }

}

extension ObservationVC: UITableViewDelegate, UITableViewDataSource {

    func updateTableView() {
        self.tableView.reloadData()
    }
    func up(sender: UIButton){
        let index = sender.tag
        let o = observations[index]
        if o.rank > 0 {
            let before = observations[index - 1]
            before.rank += 1
            o.rank -= 1
            reloadTableViewData()
        }
    }
    
    func down(sender: UIButton){
        let index = sender.tag
        let o = observations[index]
        if o.rank < observations.count - 1 {
            let after = observations[index + 1]
            after.rank -= 1
           o.rank += 1
            reloadTableViewData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let observation = observations[indexPath.row]
        let comments = retrieveComments(observation: observation)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObservationCell") as! ObservationCell
        cell.configure(observation: observation, comments: comments)
        cell.upBtn.addTarget(self, action: #selector(up(sender:)), for: .touchUpInside)
        cell.downBtn.addTarget(self, action: #selector(down(sender:)), for: .touchUpInside)
        cell.upBtn.tag = indexPath.row
        cell.downBtn.tag = indexPath.row
        cell.selectionStyle = .default
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = Color.lightCellColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID.commentsVC, sender: nil)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //allows delete
        if (editingStyle == .delete){
            let observation = observations[indexPath.row]
            context.delete(observation)
            delegate.saveContext()
            reloadTableViewData()
        }
    }
}
