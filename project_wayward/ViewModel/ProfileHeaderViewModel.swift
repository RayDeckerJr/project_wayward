//
//  ProfileHeaderViewModel.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import UIKit

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
    
    var followButtonText: String {
        if user.isCurrentUser{
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor : UIColor{
        return user.isCurrentUser ? .white : .black
    }
    
    var followButtonTextColor : UIColor{
        return user.isCurrentUser ? .black : .white
    }
    var numberOfFollower: NSAttributedString{
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    var numberOfFollowing: NSAttributedString{
        return attributedStatText(value: user.stats.following, label: "following")
    }
    var numberOfPosts: NSAttributedString{
        return attributedStatText(value: user.stats.posts, label: "posts")
    }
    
    
func attributedStatText(value: Int, label: String) -> NSAttributedString{
  let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
  attributedText.append(NSAttributedString(string: label, attributes: [.font:UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
  return attributedText
}
    
}
