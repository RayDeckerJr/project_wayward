//
//  AuthenticationViewModel.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/28/21.
//
import UIKit

protocol FormViewModel {
    func updateform()
    }

protocol AuthenticationViewModel {
    var formIsVaild: Bool { get }
    var buttonBackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

struct LoginViewModel:AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsVaild: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor{
        return formIsVaild ? .systemTeal:.darkGray.withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor{
        return formIsVaild ? .white : UIColor(white: 1, alpha: 0.9)
    }
    
}
struct RegistrationViewModel: AuthenticationViewModel {

    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var biotext: String?
    
    
    var formIsVaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsVaild ? .systemTeal:.darkGray.withAlphaComponent(0.5)
        
    }
    
    var buttonTitleColor: UIColor{
        return formIsVaild ? .white : UIColor(white: 1, alpha: 0.9)
        
    }
    
}
