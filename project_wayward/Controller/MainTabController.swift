//
//  MainTabController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/27/21.
//

import UIKit
import Firebase
import YPImagePicker

    
class MainTabController: UITabBarController {
    
    //MARK: - Lifecycle
    
    private var user: User? {
        didSet{
            guard let user = user else {return}
            configureViewControllers(withUser: user)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
        
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
    }
 
    //MARK: - Helpers
    
    func configureViewControllers(withUser user: User) {
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        
        let feed = templeteNavigationController(unselectedImage: #imageLiteral(resourceName: "052-house").withTintColor(.white), selectedImage: #imageLiteral(resourceName: "052-house-1"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templeteNavigationController( unselectedImage: #imageLiteral(resourceName: "023-search").withTintColor(.white), selectedImage: #imageLiteral(resourceName: "023-search-1"), rootViewController: SearchController())
        
        let imageselector = templeteNavigationController( unselectedImage: #imageLiteral(resourceName: "053-upload").withTintColor(.white), selectedImage: #imageLiteral(resourceName: "053-upload-1"), rootViewController: ImageSelectController())
        
        let notifications = templeteNavigationController( unselectedImage: #imageLiteral(resourceName: "013-notification").withTintColor(.white), selectedImage: #imageLiteral(resourceName: "013-notification-1"), rootViewController: NotifacationController())
        
        let profileController = ProfileController(user: user)
        let profile = templeteNavigationController(unselectedImage: #imageLiteral(resourceName: "006-user").withTintColor(.white), selectedImage: #imageLiteral(resourceName: "006-user-1"), rootViewController: profileController)
        
        viewControllers = [feed,search,imageselector,notifications,profile]
        
    }
    
    func templeteNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items,_ in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else {return}
                let controller = UploadPostController()
                controller.selectImage = selectedImage
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }

}

extension MainTabController: AuthenticationDelegate{
    func authenticationDidComplete(){
        fetchUser()
        self.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - TABDelegate

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil )
            
            didFinishPickingMedia(picker)
            
        }
        return true
    }
    
}

extension MainTabController: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
    }
    
     
}
