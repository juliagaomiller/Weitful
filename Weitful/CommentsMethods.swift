//
//  CommentsMethods.swift
//  Weitful
//
//  Created by Julia Miller on 12/20/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension CommentsVC {
    
    func animateNewCommentView(isActivated: Bool){
        if isActivated {
            clearDone.isHidden = false
            TVContainer.isHidden = false
            TVContainer.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.4, animations: {
                self.clearDone.alpha = 1
                self.TVContainer.alpha = 1
                self.TVContainer.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.textView.becomeFirstResponder()
            })
        } else {
            textView.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: {
                self.TVContainer.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                self.TVContainer.alpha = 0
                self.clearDone.alpha = 0
            }, completion: { _ in
                self.TVContainer.isHidden = true
                self.clearDone.isHidden = true
            })
            
        }
    }
    
    func hideNewCommentView(){
        thumbsUpBtn.setImage(#imageLiteral(resourceName: "thumbsupDark"), for: .normal)
        thumbsDownBtn.setImage(#imageLiteral(resourceName: "thumbsdownDark"), for: .normal)
        thumbsUpBtn.tintColor = UIColor.black
        thumbsDownBtn.tintColor = UIColor.black
        thumbsUpBtn.imageEdgeInsets = defaultThumbInset
        thumbsDownBtn.imageEdgeInsets = smallThumbInsets
    
        clearDone.isHidden = true
        TVContainer.isHidden = true
        clearDone.alpha = 0
        TVContainer.alpha = 0
        TVContainer.layer.cornerRadius = 7.0
    }
    
    func setUpTableView(){
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
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
        if observationComments.count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        for x in observationComments {
            if x.observation != observation {fatalError()}
        }
        tableView.reloadData()
    }
    
}
