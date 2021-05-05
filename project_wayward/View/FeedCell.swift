//
//  FeedCell.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/27/21.
//

import UIKit

class FeedCell: UICollectionViewCell{
    //MARK: - Properties
    var viewModel: PostViewModel? {
        didSet {configure()}
    }
    
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
        button.setTitleColor(.white, for: .normal)
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
        return iv
    }()
    //MARK: - BUTTONS
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "003-like").withTintColor(.white), for: .normal)
        button.setDimensions(height: 48, width: 48)
        button.contentMode = .scaleAspectFill
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "045-chat-1"), for: .normal)
        button.setDimensions(height: 48, width: 48)
        button.contentMode = .scaleAspectFill
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "041-paper-plane-1"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.setDimensions(height: 48, width: 48)
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .black
        
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
    //MARK: - Helpers
    func configure() {
        guard let viewModel = viewModel else {return}
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        
        
        
    }
    
    func confirgureActionsButtons(){
        let  stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton, likesLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 200, height: 48)
    }
}
