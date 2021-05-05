//
//  User.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let username: String
    let profileImageURL: String
    let greenVerified: Bool
    let blueVerified: Bool
    let bioText: String
    let uid: String
    
    var isFollowed = false
    var isCurrentUser : Bool {return Auth.auth().currentUser?.uid == uid}
    
    var stats: UserStats!
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        self.bioText = dictionary["bioText"] as? String ?? ""
        self.greenVerified = dictionary["GreenVerifiedUser"] as? Bool ?? false
        self.blueVerified = dictionary["BlueVerifiedUser"] as? Bool ?? false
        self.uid = dictionary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
    //let posts: Int
    
}
