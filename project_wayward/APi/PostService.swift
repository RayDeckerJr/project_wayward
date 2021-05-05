//
//  PostService.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestoreCompletion))
    {
        guard let uid = Auth.auth().currentUser else {return}
        imageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageurl": imageURL,
                        "ownerUid" : uid] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
