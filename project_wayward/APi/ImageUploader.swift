//
//  ImageUploader.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import FirebaseStorage

struct imageUploader{
    static func uploadImage(image: UIImage, completion: @escaping(String)-> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil){metadata, error in
            if let error = error{
                print("Debug: Failed To Upload")
                return
            }
            ref.downloadURL{(url, error) in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
            }
        
    }
    }
    
}
