//
//  TipVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class TipVC: UIViewController {
    
}

extension TipVC: UITableViewDataSource {
    
    let tips = tipDefaults()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let dictionary = tips[i]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as! TipCell
        cell.configureCell(dictionary: dictionary)
        return cell
    }
}
