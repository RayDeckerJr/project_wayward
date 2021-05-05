//
//  ProfileCell.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: - Properties
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "057-landing-page-1")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .black
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
