//
//  ChatTableViewDelegateDataSource.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    weak var view: ChatsViewController?
    var usuarioArray = ["John Win", "Rhyssand", "Morrigan"]
    var filtered = [Friends]()

    init (view: ChatsViewController){
        self.view = view
    }
    
    func filterArray(searchIn: String){
        let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
        let searchText = searchIn.folding(options: options, locale: nil)
        if let chatArray = view?.chatArray {
            filtered = chatArray.filter( { (mensagem) -> Bool in
                guard !searchText.isEmpty else {
                           return true
                  }
                let nameToCompare = mensagem.name.folding(options: options, locale: nil)
                print(nameToCompare.contains(searchText))
                return nameToCompare.contains(searchText)
           })
        }
       
        view?.messageTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered.count > 0 {
            return filtered.count
        }
        return view?.chatArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        
        if filtered.count > 0 {
           let filteredPath = filtered[indexPath.row]
            cell.setup(user: filteredPath)
        }else if let indexpath = view?.chatArray[indexPath.row]{
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            filterArray(searchIn: searchText)
        }
        if searchText == "" {
            self.filtered.removeAll()
            view?.messageTableView.reloadData()
        }
    }
    
}
