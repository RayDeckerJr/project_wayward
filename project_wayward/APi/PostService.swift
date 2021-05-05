//
//  PostService.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct PostService {
    static func uploadPost(user: User ,caption: String, image: UIImage, completion: @escaping(FirestoreCompletion))
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        imageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageurl": imageURL,
                        "ownerUid" : uid,
                        "ownerImageUrl": user.profileImageURL,
                        "ownerUsername": user.username
                        //ADD MORE FIELDS HERE FOR UPLOAD
            ] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping ([Post])-> Void) {
        COLLECTION_POSTS.order(by: "timestamp").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            let posts = documents.map({Post(postID: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
}
