//
//  UploadPostController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import UIKit

class UploadPostController: UIViewController {
    //MARK: - Properties
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "061-save-button-1")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter Caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
       return label
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Actions
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapDone(){
        
    }
    //MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .black
        
        navigationItem.title = "Upload"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top:photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                               paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor,
                                   paddingRight: 12)
    }
}
