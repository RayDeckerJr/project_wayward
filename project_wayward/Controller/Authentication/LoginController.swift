//
//  LoginController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/28/21.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

class LoginController: UIViewController{
    
    //MARK: - Properties
    private var viewModel = LoginViewModel()
    weak var delegate:AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Logo2"))
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .systemTeal
        return iv
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
    
    private let loginInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Don't have an account?", secondPart: "Sign up.")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    //MARK: - Actions
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func  loginButtonHandler(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print ("DEBUG: Failed To Login \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        } else{
            viewModel.password = sender.text
        }
        
        updateform()
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configireNotifacationObservers()
    }
    //MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80 , width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginInButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    func configireNotifacationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
//MARK: - FormViewModel
extension LoginController: FormViewModel{
    func updateform() {
        loginInButton.backgroundColor = viewModel.buttonBackgroundColor
        loginInButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginInButton.isEnabled = viewModel.formIsVaild
    }
    
    
}

