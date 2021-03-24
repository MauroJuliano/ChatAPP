//
//  FriendsViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 24/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    var view: FriendsViewController?
    
    init(view: FriendsViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        return cell
    }
    
    
}
