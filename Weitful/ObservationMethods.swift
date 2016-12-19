import UIKit
import CoreData

extension ObservationVC {
    
    func addSwipe(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadTableViewData(){
        print("reloading tableview information")
        updateObservations()
        updateComments()
        tableView.isHidden = false
        tableView.reloadData()
        if observations.count == 0 {
            tableView.isHidden = true
        }
    }
    
    func retrieveComments(observation: Observation)->[ObservationComments]{
        var array = [ObservationComments]()
        for x in comments {
            if x.observation == observation {
                array.append(x)
            }
        }
        return array
    }
    
    func updateComments(){
        comments.removeAll()
        let request: NSFetchRequest<ObservationComments> = ObservationComments.fetchRequest()
        do {comments = try context.fetch(request)} catch {fatalError()}
    }
    
    func fetchObservations()->[Observation]{
        let request: NSFetchRequest<Observation> = Observation.fetchRequest()
        do {let array = try context.fetch(request)
            return array
        } catch {fatalError()}
    }
    
    func updateObservations(){
        var array = fetchObservations()
        array = array.sorted(by: {$0.rank < $1.rank})
        observations = array
    }

    
}
