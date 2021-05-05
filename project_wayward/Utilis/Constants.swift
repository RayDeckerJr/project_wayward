//
//  Constants.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import Firebase
import FirebaseFirestore
import FirebaseCore

let COLLECTION_USERS = Firestore.firestore().collection("userdatabase")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
