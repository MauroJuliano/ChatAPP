//
//  RegisterViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 23/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class RegisterViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    var controller: RegisterViewControllerDelegate?
    var isChecked: Bool = true
    //textField
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var reentryPasswordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = RegisterViewControllerDelegate(view: self)
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        //set corner radius
        bottomView.roundCorners(.topRight, radius: 80)
        topView.roundCorners(.bottomLeft, radius: 80)
        
        //get gradient color
        guard let otherColor = GradientColors(rawValue: "dirtyFog") else {return}
        //set gradient configuration
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: bottomView.frame.size.width, height: bottomView.frame.size.height)
        
        bottomView.layer.insertSublayer(gradientLayer, below: bottomView.layer.sublayers?.last)
        detailView.backgroundColor = otherColor.gradient.first
        
    }

    @IBAction func checkBoxButton(_ sender: Any) {
        checkTerms()
    }
    
    private func checkTerms(){
        guard isChecked == true else {
            checkBoxButton.setImage(UIImage(systemName: ""), for: .normal)
            return isChecked = true
        }
        isChecked = false
        checkBoxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        controller?.createUser(completionHandler: {success, _ in
            if success {
                 if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? TabBarViewController {
                         vc.modalPresentationStyle = .fullScreen
                          self.present(vc, animated: true, completion: nil)
            }
            }
        })
    }
    
}
