//
//  StatusViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 01/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class StatusViewControllerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var view: StatusViewController?
    init(view: StatusViewController){
        self.view = view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return view?.status.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadStatusCell", for: indexPath) as! LoadStatusCollectionViewCell
        if let index = view?.status[indexPath.row]{
            cell.setup(status: index)
        }
        return cell
    }
    
    
}
