//
//  StatusViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 01/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView
class StatusViewControllerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var view: StatusViewController?
    var currentRow = 0
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
        cell.buttonTapped = {
            self.scrollToIndex(index: indexPath, left: false)
        }
        cell.leftButton = {
            self.scrollToIndex(index: indexPath, left: true)
        }
        return cell
    }
    
    func scrollToIndex(index: IndexPath, left: Bool){
      
        var row = 0
        
        if left == true {
            row = index.row - 1
        }else{
            row = index.row + 1
        }
        
        let indexPath = [0, row] as IndexPath
        view?.statusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        view?.pageControl.currentPage = indexPath.row as! Int
    }
    
}
