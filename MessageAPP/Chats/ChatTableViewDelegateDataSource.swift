//
//  ChatTableViewDelegateDataSource.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var view: ChatsViewController?
    var usuarioArray = ["John Win", "Rhyssand", "Morrigan"]
    

    init (view: ChatsViewController){
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view?.chatArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        if let indexpath = view?.chatArray[indexPath.row]{
             cell.setup(user: indexpath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = MessageViewController()
        vc.title = "Chat"
        if let indexpath = view?.chatArray[indexPath.row]{
            vc.chatIdSelected = indexpath
        }
        view?.navigationController?.pushViewController(vc, animated: true)
        //show messages
    }
    
}
