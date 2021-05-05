//
//  Post.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timeStamp: Timestamp
    let postID: String
    
    init(postID: String, dictionary: [String: Any]) {
        self.postID = postID
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageurl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
//        self.postID = dictionary["uid"] as? String ?? ""
    }
    
}
