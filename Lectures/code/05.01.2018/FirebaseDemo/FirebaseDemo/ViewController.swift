//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Emil Atanasov on 5.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func uploadImage(_ sender: Any) {
        Auth.auth().signInAnonymously() { [weak self] (user, error) in
            // ...
            let isAnonymous = user!.isAnonymous  // true
            let uid = user!.uid
            
            print("UID: \(uid)")
            
            let storageRef = Storage.storage().reference()
            
            let imageRef = storageRef.child("user/\(uid)/image.jpg")
        
            // Create file metadata including the content type
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            if let image = self?.image {
                let data = UIImagePNGRepresentation(image)
                // Upload data and metadata
                let uploadTask = imageRef.putData(data!, metadata: metadata)

                
                uploadTask.observe(.progress) { snapshot in
                    // Upload reported progress
                    let complete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                        / Double(snapshot.progress!.totalUnitCount)
                    
                    print("Progress: \(complete)")
                }

                
                uploadTask.observe(.success) { snapshot in
                    // Upload completed successfully
                    print("File was uploaded.")
                    let url = snapshot.reference.downloadURL { url, error in
                        if let error = error {
                            print("Error: \(error)")
                        } else {
                            print("Public download URL: \(String(describing: url))")
                        }
                    }
                }


                
                uploadTask.observe(.failure) { snapshot in
                    if let error = snapshot.error as NSError? {
                        switch (StorageErrorCode(rawValue: error.code)!) {
                        case .objectNotFound:
                            // File doesn't exist
                            print("object not found")
                            break
                        case .unauthorized:
                            // User doesn't have permission to access file
                            print("user has no permissions")
                            break
                        case .cancelled:
                            // User canceled the upload
                            print("upload was cancelled")
                            break
                            
                            /* ... */
                            
                        case .unknown:
                            // Unknown error occurred, inspect the server response
                            break
                        default:
                            // A separate error occurred. This is a good place to retry the upload.
                            break
                        }
                    }
                }
            }
            

        }
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
//            image = editedImage
            image = self.scale(image: editedImage, toSize: CGSize(width:500, height:500))
        } else if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = chosenImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func scale(image: UIImage, toSize size:CGSize) -> UIImage? {
        //to keep the aspect ration then newSize should be modified
        let newSize = size
        //any other liner transformation should be applied
        //to the final image canvas
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        //and the place where the image should be drawn
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

