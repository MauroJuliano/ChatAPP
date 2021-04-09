//
//  CustomChatsViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 09/04/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
class CustomChatsViewControllerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    var view = CustomChatViewController()
    var gradientArray = ["cherryBlossoms", "dirtyFog", "almost", "moor", "aqualicious", "siriusTamed", "jonquil", "alostmemory", "blurrybeach", "daytripper", "pinotnoir", "miaka", "influenza", "calmdarya", "stellar", "moonrise", "peach","dracula","mantle", "titanium", "seablizz","mystic","shroomhaze","electricviolet","kashmir","steelgray","pinky","purpleparadise", "aubergine", "rosewater"," montecarlo"]
    init(view: CustomChatViewController){
        self.view = view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gradientArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! CustomChatsCollectionViewCell
        cell.setup(colors: gradientArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = gradientArray[indexPath.row]
        var isSender = true
        print(collectionView.description)
        if collectionView == view.colors2CollectionView {
            isSender = false
        }
        setup(colors: color, isSender: isSender)
    }
    
    func setup(colors: String, isSender: Bool){
        if isSender == true {
            
                   let gradientLayer = CAGradientLayer()
                    guard let otherColor = GradientColors(rawValue: colors) else {return}
                           
                           gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
                           gradientLayer.locations = [0.0 , 1.0]
                           gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                           gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
                   gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: view.senderChat.frame.size.width, height: view.senderChat.frame.size.height)
                          
                   view.senderChat.layer.addSublayer(gradientLayer)
        }else {
            
             
             let secondGradientLayer = CAGradientLayer()
               guard let secondColor = GradientColors(rawValue: colors) else {return}
                      
                      secondGradientLayer.colors = [secondColor.gradient.first.cgColor, secondColor.gradient.second.cgColor]
                      secondGradientLayer.locations = [0.0 , 1.0]
                      secondGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                      secondGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
              secondGradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: view.receiverChat.frame.size.width, height: view.receiverChat.frame.size.height)
                     
              view.receiverChat.layer.addSublayer(secondGradientLayer)
        }

       // view.senderChat.layer.insertSublayer(gradientLayer, below: view.senderChat.layer.sublayers?.last)
               
     }
    
}
