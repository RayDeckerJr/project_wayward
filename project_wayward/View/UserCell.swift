//
//  UserCell.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/2/21.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - Properties
    
    var viewModel: UserCellViewModel?{
        didSet {
                    configure()
            if viewModel?.blueVerified == true{
                verifiedBadgeBlue.image = #imageLiteral(resourceName: "BlueTick")
            }
            if viewModel?.greenVerified == true{
                verifiedBadgeGreen.image = #imageLiteral(resourceName: "GreenTick")
            }
            }
        }
    

    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
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
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "User"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        label.text = "Name"
        return label
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 45, width: 45)
        profileImageView.layer.cornerRadius = 45/2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(verifiedBadgeBlue)
        verifiedBadgeBlue.setDimensions(height: 10, width: 10)
        addSubview(verifiedBadgeGreen)
        verifiedBadgeGreen.setDimensions(height: 10, width: 10)
        
        let badgeStack = UIStackView(arrangedSubviews: [verifiedBadgeGreen,verifiedBadgeBlue])
        badgeStack.axis = .horizontal
        badgeStack.spacing = 4
        badgeStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [badgeStack, usernameLabel,fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,
                      paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Helpers
    func configure(){
        guard let viewModel = viewModel else {return}
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }

}

