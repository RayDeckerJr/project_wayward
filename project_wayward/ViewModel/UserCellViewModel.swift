//
//  UserCellViewModel.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/3/21.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageURL)
    }
    var username: String {
        return user.username
    }
    var fullname: String {
        return user.username
    }
    var blueVerified: Bool{
        return user.blueVerified
    }
    var greenVerified: Bool {
        return user.greenVerified
    }
    init(user: User) {
        self.user = user
    }
}
