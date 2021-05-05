//
//  ProfileHeader.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/29/21.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: AnyObject {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            configure()
            if viewModel?.blueVerified == true {
                verifiedBadgeBlue.image = #imageLiteral(resourceName: "BlueTick")
                profileImageView.layer.borderColor = UIColor.systemBlue.cgColor
            }
            if viewModel?.greenVerified == true {
                verifiedBadgeGreen.image = #imageLiteral(resourceName: "GreenTick")
                profileImageView.layer.borderColor = UIColor.systemGreen.cgColor
            }
            if viewModel?.greenVerified == true && viewModel?.blueVerified == true{
                profileImageView.layer.borderColor = UIColor.systemYellow.cgColor
            }
        }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.systemGray.cgColor
        iv.layer.borderWidth = 2.5
        iv.clipsToBounds = true
        iv.backgroundColor = .systemTeal
        
        return iv
    }()
    
    private let verifiedBadgeBlue: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    private let verifiedBadgeGreen: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
        
    }()
    
    private let bioTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setImage(#imageLiteral(resourceName: "037-settings"), for: .normal)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
        
    }()
    
    private lazy var FollowersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
        
    }()
    
    private lazy var FollowingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
        
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "011-menu-1"),for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 1)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "057-landing-page-1"),for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 1)
        return button
    }()
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "061-save-button-1"),for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 1)
        return button
    }()
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else {return}
        nameLabel.text = viewModel.fullname
        bioTextLabel.text = viewModel.bioText
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        postsLabel.attributedText = viewModel.numberOfPosts
        postsLabel.textColor = .white
        FollowersLabel.attributedText = viewModel.numberOfFollower
        FollowersLabel.textColor = .white
        FollowingLabel.attributedText = viewModel.numberOfFollowing
        FollowingLabel.textColor = .white
    }
          

    
    //MARK: - Actions
    @objc func handleEditProfileFollowTapped(){
        guard let viewModel = viewModel else {return}
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80/2

        
        let topDivider = UIView()
        topDivider.backgroundColor = .white
        
        let bottomDivider = UIView()
        topDivider.backgroundColor = .white
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,width: 50, height: 50)
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        let statsStack = UIStackView(arrangedSubviews: [postsLabel,FollowersLabel,FollowingLabel])
            addSubview(statsStack)
            statsStack.distribution = .fillEqually
            statsStack.anchor(left: leftAnchor, bottom: topDivider.topAnchor, right: rightAnchor,
                         paddingLeft: 2,paddingBottom: 2, paddingRight: 2, height: 50)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 16, width: 120)
        
        addSubview(verifiedBadgeBlue)
        verifiedBadgeBlue.setDimensions(height: 12, width: 12)
        addSubview(verifiedBadgeGreen)
        verifiedBadgeGreen.setDimensions(height: 12, width: 12)
        
        let badgeStack = UIStackView(arrangedSubviews: [verifiedBadgeGreen,verifiedBadgeBlue])
        badgeStack.axis = .horizontal
        badgeStack.spacing = 4
        badgeStack.alignment = .leading

        let nameStack = UIStackView(arrangedSubviews: [nameLabel, badgeStack])
        nameStack.distribution = .equalSpacing
        addSubview(nameStack)
        nameStack.centerY(inView: profileImageView)
        nameStack.anchor(left: profileImageView.rightAnchor, paddingLeft: 18, height: 50)
        nameStack.axis = .horizontal
        nameStack.spacing = 4
        nameStack.alignment = .leading
        
        addSubview(bioTextLabel)
        bioTextLabel.anchor(top: nameLabel.bottomAnchor, left:profileImageView.rightAnchor, paddingTop: 4 , paddingLeft: 18)
        
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
