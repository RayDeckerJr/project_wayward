//
//  UploadPostController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/5/21.
//

import UIKit

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    //MARK: - Properties
    
    weak var delegate:UploadPostControllerDelegate?
    var currentUser: User?
    
    var selectImage: UIImage? {
        didSet{photoImageView.image = selectImage}
    }
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter Caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        tv.placeholderShouldCenter = false
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)

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
        guard let image = selectImage else {return}
        guard let caption = captionTextView.text  else { return}
        guard let user = currentUser else {return}
        showLoader(true)
        PostService.uploadPost(user: user, caption: caption, image: image) { error in
            self.showLoader(false)
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
        self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    //MARK: - Helpers
    func checkMaxLength(_ textView: UITextView, maxLength: Int){
        if textView.text.count > maxLength {
            textView.deleteBackward()
        }
    }
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
                                   paddingBottom: -12,paddingRight: 12)
    }
}
// MARK: - TEXTFIELD DELEGATE
extension UploadPostController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView, maxLength: 140)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/140"
    }
}
