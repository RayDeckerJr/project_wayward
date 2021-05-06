//
//  PostViewModel.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import Foundation

struct PostViewModel {
    let post: Post
    var imageUrl: URL? {return URL(string: post.imageUrl)}
    var caption: String {return post.caption}
    var likes: Int {return post.likes}
    var userProfileUrl: URL?{return URL(string: post.ownerImageUrl)}
    var username: String {return post.ownerUsername}
    var likesLabelText: String {
        if post.likes != 1
        {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    init(post: Post) {
        self.post = post
    }
}
