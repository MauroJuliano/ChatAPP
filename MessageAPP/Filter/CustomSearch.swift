//
//  Filter.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 29/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit

class ExpandableView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
