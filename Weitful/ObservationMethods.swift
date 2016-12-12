import UIKit
import CoreData

extension ObservationVC {
    
    func addSwipe(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
//    func updateIndexes(array: [Observation])->[Observation]{
//        var i = 0
//        for x in array {
//            x.rank = i
//            i += 1
//        }
//        var newArray = array.sorted(by: {$0.rank < $1.rank})
//        delegate.saveContext()
//        for x in array {
//            print(x.text!, x.rank)
//        }
//        return array
//    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadTableViewData(){
        tableView.isHidden = false
        tableView.reloadData()
        if returnCorrectArray().count == 0 {
            tableView.isHidden = true
        }
    }
    
    func revertAllBtnsToDefault(){
        exerciseBtn.setTitle(Type.exercise.rawValue, for: .normal)
        eatingBtn.setTitle(Type.eating.rawValue, for: .normal)
        neitherBtn.setTitle(Type.neither.rawValue, for: .normal)
    }
    
    func returnCorrectTypeForBtn(btn: UIButton)-> Type {
        let type: Type!
        if btn == exerciseBtn {type = .exercise}
        else if btn == eatingBtn {type = .eating}
        else {type = .neither}
        return type
    }
    
    func handleButtonInput(btn: UIButton){
        let type = returnCorrectTypeForBtn(btn: btn)
        currentTable = type
        updateObservationArrays()
        if btn.currentTitle == "+" {
            performSegue(withIdentifier: segueID.newObservationVC, sender: self)
            btn.setTitle(type.rawValue, for: .normal) //e.g. EXERCISE
        } else {
            revertAllBtnsToDefault()
            btn.setTitle("+", for: .normal)
        }
        reloadTableViewData()
    }
    
    func sortObservationsIntoAppropriateArrays(array: [Observation]){
        eatingArray.removeAll()
        exerciseArray.removeAll()
        neitherArray.removeAll()
        if array.count == 0 {return}
        for o in array {
            if o.type == .exercise {exerciseArray.append(o)
            } else if o.type == .eating {eatingArray.append(o)
            } else { neitherArray.append(o)}
//            eatingArray = sortObservationsByRank(array: eatingArray)
//            exerciseArray = sortObservationsByRank(array: exerciseArray)
//            neitherArray = sortObservationsByRank(array: neitherArray)
            for x in eatingArray {
                print(x.text!, x.rank)
            }
        }
    }
    
//    func sortObservationsByRank(array: [Observation])->[Observation]{
//        if array.count <= 1 {
//            return array
//        } else {
//            let newArray = array.sorted(by: {$0.rank < $1.rank})
//            return newArray
//        }
//        
//    }
    
    func fetchObservations()->[Observation]{
        let request: NSFetchRequest<Observation> = Observation.fetchRequest()
        do {let array = try context.fetch(request)
            return array
        } catch {fatalError()}
    }
    
    func updateObservationArrays(){
        //import from core data and populate arrays
        let array = fetchObservations()
        if array.count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            sortObservationsIntoAppropriateArrays(array: array)
        }
    }
    
    func returnCorrectArray()->[Observation]{
        var array: [Observation]!
        if currentTable == .eating {array =  eatingArray}
        else if currentTable == .exercise {array =  exerciseArray}
        else {array = neitherArray}
        array = array.sorted(by: {$0.rank < $1.rank})
        return array
    }
    
//    func addLongPress(){
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(moveSelectedCell(gestureRecognizer:)))
//        tableView.addGestureRecognizer(longPress)
//    }
    
//    func moveSelectedCell(gestureRecognizer: UILongPressGestureRecognizer){
//        let longPress = gestureRecognizer as UILongPressGestureRecognizer
//        let state = longPress.state
//        let locationInView = longPress.location(in: tableView)
//        var indexPath = tableView.indexPathForRow(at: locationInView)
//        var array = returnCorrectArray()
//        
//        struct My {
//            static var cellSnapshot : UIView? = nil
//        }
//        struct Path {
//            static var initialIndexPath : NSIndexPath? = nil
//        }
//        switch state {
//        case UIGestureRecognizerState.began:
//            if indexPath != nil {
//                Path.initialIndexPath = indexPath as NSIndexPath?
//                let optional = tableView.cellForRow(at: indexPath!) as UITableViewCell!
//                guard let cell = optional else {fatalError()}
//                My.cellSnapshot  = snapshopOfCell(inputView: cell)
//                var center = (cell.center)
//                My.cellSnapshot!.center = center
//                My.cellSnapshot!.alpha = 0.0
//                tableView.addSubview(My.cellSnapshot!)
//                
//                UIView.animate(withDuration: 0.25, animations: { () -> Void in
//                    center.y = locationInView.y
//                    My.cellSnapshot!.center = center
//                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
//                    My.cellSnapshot!.alpha = 0.98
//                    cell.alpha = 0.0
//                    
//                }, completion: { (finished) -> Void in
//                    if finished {
//                        cell.isHidden = true
//                    }
//                })
//            }
//        case UIGestureRecognizerState.changed:
//            var center = My.cellSnapshot!.center
//            center.y = locationInView.y
//            My.cellSnapshot!.center = center
//            if ((indexPath != nil) && (indexPath != Path.initialIndexPath as? IndexPath)) {
//                array.insert(array.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
//                array = updateObservationIndexes(array: array)
//                tableView.moveRow(at: Path.initialIndexPath! as IndexPath, to: indexPath!)
//                Path.initialIndexPath = indexPath as NSIndexPath?
//            }
//        default:
//            let optional = tableView.cellForRow(at: Path.initialIndexPath! as IndexPath) as UITableViewCell!
//            guard let cell = optional else {fatalError()}
//            cell.isHidden = false
//            cell.alpha = 0.0
//            UIView.animate(withDuration: 0.25, animations: { () -> Void in
//                My.cellSnapshot!.center = cell.center
//                My.cellSnapshot!.transform = CGAffineTransform.identity
//                My.cellSnapshot!.alpha = 0.0
//                cell.alpha = 1.0
//            }, completion: { (finished) -> Void in
//                if finished {
//                    Path.initialIndexPath = nil
//                    My.cellSnapshot!.removeFromSuperview()
//                    My.cellSnapshot = nil
//                }
//            })
//        }
//        
//        
//    }
//    
//    func snapshopOfCell(inputView: UIView) -> UIView {
//        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
//        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
//        UIGraphicsEndImageContext()
//        let cellSnapshot : UIView = UIImageView(image: image)
//        cellSnapshot.layer.masksToBounds = false
//        cellSnapshot.layer.cornerRadius = 0.0
//        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
//        cellSnapshot.layer.shadowRadius = 5.0
//        cellSnapshot.layer.shadowOpacity = 0.4
//        return cellSnapshot
//    }

    
    
}
