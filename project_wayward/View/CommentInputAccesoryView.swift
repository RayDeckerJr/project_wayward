//
//  CommentInputAccesoryView.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/6/21.
//

import UIKit

class CommentInputAccesoryView: UIView {
    // MARK: - Properties
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter Comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = true
        return tv
    }()
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "017-add-button-1"), for: .normal)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    // MARK: - Actions
    @objc func handlePostTapped(){
        
    }
}
