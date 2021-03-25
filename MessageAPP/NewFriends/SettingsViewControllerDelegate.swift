//
//  SettingsViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 25/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewControllerDelegate: NSObject, UITableViewDataSource, UITableViewDelegate{
    var view: SettingsViewController?
    var settingsArray = ["Edit Profile", "Chats"]
    init(view: SettingsViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! settingsTableViewCell

        cell.settingsLabel.text = settingsArray[indexPath.row]
        
            return cell
        
    }
    
    
}
