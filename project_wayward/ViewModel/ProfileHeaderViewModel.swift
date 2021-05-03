//
//  ProfileHeaderViewModel.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    var profileImageURL: URL?{
        return URL(string: user.profileImageURL)
    }
    
    var greenVerified: Bool{
        return user.greenVerified
    }
    var blueVerified: Bool{
        return user.blueVerified
    }
    
    var bioText: String{
        return user.bioText
    }
    
    init(user: User) {
        self.user = user
    }
}
