//
//  InputTextView.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import UIKit

class InputTextView: UITextView {
    //MARK: - Properties
    var placeholderText: String? {
        didSet {placeHolderLabel.text = placeholderText}
    }
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super .init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4,paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func handleTextDidChange(){
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
