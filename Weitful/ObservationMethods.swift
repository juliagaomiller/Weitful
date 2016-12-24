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
    
    func animateNewObservationView(isActivated: Bool){
        if isActivated {
            clearDone.isHidden = false
            newObservTV.isHidden = false
            TVborder.isHidden = false
            TVborder.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.4, animations: {
                self.clearDone.alpha = 1
                self.newObservTV.alpha = 1
                self.TVborder.alpha = 1
                self.TVborder.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.newObservTV.becomeFirstResponder()
            })
        } else {
            newObservTV.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: {
                self.TVborder.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                self.TVborder.alpha = 0
                self.clearDone.alpha = 0
                self.newObservTV.alpha = 0
            }, completion: { _ in
                self.TVborder.isHidden = true
                self.clearDone.isHidden = true
                self.newObservTV.isHidden = true
            })
            
        }
    }
    
    func hideNewObservationView(){
        newObservTV.text = ""
        clearDone.isHidden = true
        newObservTV.isHidden = true
        TVborder.isHidden = true
        clearDone.alpha = 0
        newObservTV.alpha = 0
        TVborder.alpha = 0
        TVborder.layer.cornerRadius = 7.0
    }

    
}
