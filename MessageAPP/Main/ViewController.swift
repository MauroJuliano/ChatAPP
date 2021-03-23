//
//  ViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 19/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var buttomView: RoundedView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var signInLabel: UILabel!
    
    //TextField
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    func setupUI(){
        topView.roundCorners(.bottomLeft, radius: 50)
        detailView.roundCorners(.topRight, radius: 40)
        buttomView.roundCorners(.allCorners, radius: 30)
        guard let otherColor = GradientColors(rawValue: "dirtyFog") else {return}
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        let gradientButton: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: topView.frame.size.width, height: topView.frame.size.height)
        
        // gradient to button Sign in
        
        gradientButton.colors = [otherColor.gradient.first.cgColor, otherColor.gradient.second.cgColor]
        gradientButton.locations = [0.0 , 1.0]
        gradientButton.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientButton.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientButton.frame = CGRect(x: 0.0, y: 0.0, width: buttomView.frame.size.width, height: buttomView.frame.size.height)
        
        topView.layer.insertSublayer(gradientLayer, below: topView.layer.sublayers?.last)
        backView.backgroundColor = otherColor.gradient.second
        
        signInLabel.textColor = .white
        buttomView.backgroundColor = otherColor.gradient.second
        
        buttomView.layer.insertSublayer(gradientButton, below: buttomView.layer.sublayers?.last)
        
        //setGradientToLabel(gradientLayer: gradientLayer)
    }
    
    func setGradientToLabel(gradientLayer: CAGradientLayer){
         let teste = gradientLayer
         signInLabel.textColor = gradientColor(bounds: signInLabel.bounds, gradientLayer: teste)
    }
    
    func doLogin(completionHandler: @escaping (_ result: Bool, _ error: Bool?) -> Void ){
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty, !password.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (_, error) in
            if let error = error {
                completionHandler(false,nil)
                return
            }
            completionHandler(true,nil)
        })
    }
    
    func gradientColor(bounds: CGRect, gradientLayer : CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        doLogin(completionHandler: { success, _ in
            if success {
                if let vc = UIStoryboard(name: "Chats", bundle: nil).instantiateInitialViewController() as? ChatsViewController {
                           vc.modalPresentationStyle = .fullScreen
                           self.present(vc, animated: true, completion: nil)
                }
            }
        })
       
    }
    @IBAction func registerButton(_ sender: Any) {
       if let vc = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as? RegisterViewController {
        present(vc, animated: true, completion: nil)
        
       }
    }
    
}
