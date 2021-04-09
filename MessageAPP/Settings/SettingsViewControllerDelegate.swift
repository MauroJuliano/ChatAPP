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
    var settingsArray = ["Account", "Chats"]
    init(view: SettingsViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! settingsTableViewCell

        cell.settingsLabel.text = settingsArray[indexPath.row]
        if cell.settingsLabel.text == "Account" {
            cell.imageIcon.image = UIImage(systemName: "person.fill")
            cell.roundedImage.backgroundColor = UIColor(hexString: "9d92e7")
        }else{
            cell.imageIcon.image = UIImage(systemName: "square.and.pencil")
            cell.roundedImage.backgroundColor = UIColor(hexString: "7dc6ea")
        }
            return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! settingsTableViewCell
        
        var myCustomSelection = UIView()
        myCustomSelection.backgroundColor = UIColor(hexString: "DCD3FF")
        cell.selectedBackgroundView = myCustomSelection
        
        if cell.settingsLabel.text == "Account" {
            if let vc = UIStoryboard(name: "EditProfile", bundle: nil).instantiateInitialViewController() as? EditProfilerViewController {
                vc.users.append(contentsOf: self.view!.users)
                
                self.view?.navigationController?.pushViewController(vc, animated: true)
            }
        }else if  cell.settingsLabel.text == "Chats"{
            if let vc = UIStoryboard(name: "CustomChat", bundle: nil).instantiateInitialViewController() as? CustomChatViewController {

                           self.view?.navigationController?.pushViewController(vc, animated: true)
                       }
        }
    }
    
    func navigateTo(name: String, vc: UIViewController){
        
    }
    
}
