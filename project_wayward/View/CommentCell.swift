//
//  CommentCell.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/6/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let verifiedBadgeBlue: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "BlueTick")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    private let verifiedBadgeGreen: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "GreenTick")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    
    private let CommentLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "User ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Comment", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
        label.textColor = .white
        return label
    }()
    // MARK: - Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(verifiedBadgeBlue)
        verifiedBadgeBlue.setDimensions(height: 12, width: 12)
        addSubview(verifiedBadgeGreen)
        verifiedBadgeGreen.setDimensions(height: 12, width: 12)
        
        let badgeStack = UIStackView(arrangedSubviews: [verifiedBadgeGreen,verifiedBadgeBlue])
        badgeStack.axis = .horizontal
        badgeStack.spacing = 4
        badgeStack.alignment = .leading
        
        
        addSubview(badgeStack)
        
        badgeStack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 4)
        
        addSubview(CommentLabel)
        CommentLabel.centerY(inView: badgeStack, leftAnchor: badgeStack.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
