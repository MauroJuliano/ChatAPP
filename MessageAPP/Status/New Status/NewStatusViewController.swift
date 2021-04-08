//
//  NewStatusViewController.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 30/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseAuth
import Firebase
import SmoothButton
import SkeletonView

class NewStatusViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ref: DatabaseReference = Database.database().reference()
     private let db = Firestore.firestore()
    

    @IBOutlet weak var sendTo: RoundedView!
    private var gameTimer: Timer?
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var uploadButton: SmoothButton!
    @IBOutlet weak var barRight: UIView!
    @IBOutlet weak var barLeft: UIView!
    @IBOutlet weak var roundLeft: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skeletonViewText: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.layer.cornerRadius = 25
        blurView.clipsToBounds = true
        uploadButton.isHidden = true

        sendToConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
        imageView.isSkeletonable = true
        imageView.showAnimatedSkeleton()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            guard imageView == nil else { return }
            openCamera()
        }else{
            guard imageView == nil else { return }
            noCamera()
        }
        
    }
    func sendToConfig(){
            guard let otherColor = GradientColors(rawValue: "dirtyFog") else {return}
        uploadButton.gradientStartColor = otherColor.gradient.first
        uploadButton.gradientEndColor = otherColor.gradient.second
        
          guard let gradientColor = GradientColors(rawValue: "shroomhaze") else {return}
          let gradientLayer: CAGradientLayer = CAGradientLayer()

          gradientLayer.colors = [gradientColor.gradient.first.cgColor, gradientColor.gradient.second.cgColor]
          gradientLayer.locations = [0.0 , 1.0]
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
          gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewBack.frame.size.width, height: viewBack.frame.size.height)
        viewBack.layer.insertSublayer(gradientLayer, below: viewBack.layer.sublayers?.last)

       
    }
    func openCamera(){
        let pickerImage = UIImagePickerController()
        pickerImage.sourceType = .camera
        pickerImage.allowsEditing = true
        pickerImage.delegate = self
        present(pickerImage, animated: true)
    }
    
    func noCamera(){
        let alert = UIAlertController(title: "We could not acess your camera", message: "anyhow you can access your Photos and share it", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func photosButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        imageView.hideSkeleton()
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFill
            
            imageView.image = chosenImage
            uploadButton.isHidden = false
        
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendToButton(_ sender: Any) {
        
        self.uploadButton.isLoading = true
        self.uploadButton.loadingString = ""
        self.saveFIRData(completionHandler: { success, _ in
            if success {
                self.uploadButton.isLoading = false
            }
        })
        
    }
    
    @IBAction func returnButtton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveFIRData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        uploadImage(imageView.image!) {(url, error) in
            if url != nil {
                return self.saveImage(name: "", profileUrl: url!) { (url, error) in
                    completionHandler(url != nil, error)
                }
            }
            completionHandler(false,error)
        }
        
    }
    func uploadImage(_ image: UIImage, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void){
        let newChild = ref.childByAutoId()
        let storageRef = Storage.storage().reference().child("\(newChild).png")
        let imgData = imageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) {(metadata, error) in
            if error == nil {
                storageRef.downloadURL(completion: {(url, error) in
                    completionHandler(url,nil)
                })
            }else {
                completionHandler(nil, error)
            }
        }
        
    }
    
    func saveImage(name: String, profileUrl: URL, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void) {
        if let currentUserD = Auth.auth().currentUser?.uid {
            let userRef = db.collection("stories")
            let statusActive = db.collection("users").document(currentUserD).updateData(["hasStatusActive": true])
            
            let dict: [String: Any] = [
                "userID": currentUserD,
                "TimeStamp": Date().timeIntervalSince1970,
                "statusImage":  profileUrl.absoluteString ]
            
            userRef.addDocument(data: dict)
            completionHandler(profileUrl, nil)
        }
    }
}

