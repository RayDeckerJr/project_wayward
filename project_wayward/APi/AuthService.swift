//
//  AuthService.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
    let greenVerified: Bool
    let blueVerified : Bool
    let bioText: String
    
}

struct AuthService {
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    static func registerUser(withCredetial credentials: AuthCredentials, completion:
        @escaping(Error?)->Void){
        imageUploader.uploadImage(image: credentials.profileImage){ imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password){
                (result, error) in
                
                if let error = error {
                    print ("DEBUG: Could Not Create User \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "username": credentials.username,
                                           "profileImageURL": imageURL,
                                           "uid": uid,
                                           "GreenVerifiedUser": credentials.greenVerified,
                                           "BlueVerifiedUser": credentials.blueVerified,
                                           "bioText": credentials.bioText]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
            
        }
        
    }
}
