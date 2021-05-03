//
//  FeedCell.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/27/21.
//

import UIKit

class FeedCell: UICollectionViewCell{
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "006-user-1")
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("RVY", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "Logo2")
        return iv
    }()
    //MARK: - BUTTONS
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "003-like"), for: .normal)
        button.setDimensions(height: 4, width: 4)
        button.contentMode = .scaleAspectFill
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "045-chat"), for: .normal)
        button.setDimensions(height: 4, width: 4)
        button.contentMode = .scaleAspectFill
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "041-paper-plane"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.setDimensions(height: 4, width: 4)
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = " 1 Likes"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "example caption"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 Days Ago"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 12,paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor,left: leftAnchor, right: rightAnchor,
                             paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        confirgureActionsButtons()
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 2, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func didTapUsername(){
        print("Debug: did tap username")
    }
    //MARK: - Actions
    func confirgureActionsButtons(){
        let  stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton,likesLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
}
