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
        tv.placeholderShouldCenter = true
        return tv
    }()
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "045-chat").withTintColor(.white), for: .normal)
        
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8,paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .white
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor,right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize
    { return .zero}
    // MARK: - Helpers
    
    // MARK: - Actions
    @objc func handlePostTapped(){
        
    }
}
