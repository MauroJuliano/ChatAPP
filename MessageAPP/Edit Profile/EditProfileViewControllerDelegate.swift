//
//  EditProfileViewControllerDelegate.swift
//  MessageAPP
//
//  Created by Mauro Figueiredo on 30/03/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
class EditProfileViewControllerDelegate : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var view = EditProfilerViewController()
    var ref: DatabaseReference!
    private let db = Firestore.firestore()
    let uid  = Auth.auth().currentUser?.uid
    
    init(view: EditProfilerViewController){
        self.view = view
    }
    
    func changePictureButtonTapped(){
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        
        view.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            view.editImageView.contentMode = .scaleAspectFill
            view.editImageView.image = chosenImage
        }
        saveFIRData()
        view.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        view.dismiss(animated: true, completion: nil)
    }
    
    func saveFIRData() {
        self.uploadImage(view.editImageView.image!) { url in
            if url != nil {
                self.saveImage(name: "", profileURL: url!) { success in
                    if success != nil {
                        
                    }
                }
            }
        }
    }
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?) -> ())){
        let storageRef = Storage.storage().reference().child("\(uid!).png")
        let imgData = view.editImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metaData, error) in
            if error == nil {
                storageRef.downloadURL(completion: { (url, error) in
                  completion(url)
                })
            }else{
                completion(nil)
            }
        }
        
    }
    func saveImage(name: String, profileURL: URL, completion: @escaping ((_ url: URL?) -> ())) {
        if let currentUser = Auth.auth().currentUser?.uid {
            let userRef = db.collection("users")
                userRef.document("\(currentUser)").updateData([
                    
                    "imageProfile": profileURL.absoluteString
                ])
        }
        }
    }

