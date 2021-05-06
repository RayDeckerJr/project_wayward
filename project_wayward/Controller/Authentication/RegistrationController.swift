//
//  RegistrationController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/28/21.
//

import UIKit

class RegistrationController: UIViewController{
    //MARK: - Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    private let plushPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "039-photo-1"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    private let emailTextField: UITextField = {
       let tf = customTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    private let passwordTextField: UITextField = {
       let tf = customTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let fullnameTextField = customTextField(placeholder: "Fullname")
    private let usernameTextField = customTextField(placeholder: "Username")
    private let bioTextField = customTextField(placeholder: "Tell Me Something About Yourself.")
    
    private let SignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = .systemTeal
        return button
    }()
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Already have an account?", secondPart: "Sign In.")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    //MARK: - Actions
    @objc func handleSignUp(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImage else {return}
        guard let biotext = bioTextField.text else {return}

        
        let credentials = AuthCredentials( email: email, password: password,
                                          fullname: fullname, username: username,
                                          profileImage: profileImage, greenVerified: false, blueVerified: false, bioText: biotext)
        
        AuthService.registerUser(withCredetial: credentials) { error in
            if let error = error {
                print ("DEBUG: Could Not Create User \(error.localizedDescription)")
                return
            }
            
            print ("Debug: User Created Successfully!")
            self.delegate?.authenticationDidComplete()
        }
        
    }
    
    @objc func handleShowSignUp(){
        navigationController?.popViewController(animated: true)
    }
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        } else if sender == passwordTextField{
            viewModel.password = sender.text
        } else if sender == fullnameTextField{
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        updateform()
    }
    
    @objc func handleProfilePhotoSelect(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configerUI()
        configireNotifacationObservers()
    }
    
    //MARK: - Helper
    func configerUI() {
        configureGradientLayer()
        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view)
        plushPhotoButton.setDimensions(height: 140, width: 140)
        plushPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, bioTextField, SignUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    func configireNotifacationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        bioTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}
//MARK: - FormViewModel
extension RegistrationController: FormViewModel{
    func updateform() {
        SignUpButton.backgroundColor = viewModel.buttonBackgroundColor
        SignUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        SignUpButton.isEnabled = viewModel.formIsVaild
    }
}

//MARK: - UIImagePicker
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImage = selectedImage
        
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width/2
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor
        plushPhotoButton.layer.borderWidth = 2
        plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
