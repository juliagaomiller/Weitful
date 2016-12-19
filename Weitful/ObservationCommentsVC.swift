//
//  ObservationsCommentsVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/14/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ObservationCommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = delegate.persistentContainer.viewContext
    
    var observation: Observation!
    var observationComments = [ObservationComments]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        addSwipeBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateObservationComments()
        tableView.reloadData()
    }
    
    func addSwipeBack(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateObservationComments(){
        let request: NSFetchRequest<ObservationComments> = ObservationComments.fetchRequest()
        request.predicate = NSPredicate(format: "observation == %@", observation)
        do {observationComments = try context.fetch(request)} catch {fatalError()}
        observationComments.sort(by: {$0.date!.compare($1.date as! Date) == .orderedDescending})
        for x in observationComments {
            if x.observation != observation {fatalError()}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID.newCommentVC {
            let vc = segue.destination as! NewCommentVC
            vc.observation = observation
        }
    }
    
    @IBAction func newComment(){
        performSegue(withIdentifier: segueID.newCommentVC, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observationComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObservationCommentCell") as! ObservationCommentCell
        cell.configure(comment: observationComments[indexPath.row])
        return cell
    }
}


