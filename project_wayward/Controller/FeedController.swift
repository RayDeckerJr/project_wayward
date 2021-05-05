//
//  FeedController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/27/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController : UICollectionViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Actions
    @objc func handleLogout(){
            do {
                try Auth.auth().signOut()
                    let controller = LoginController()
                    controller.delegate = self.tabBarController as? MainTabController
                    let nav = UINavigationController(rootViewController: controller)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
                    print("DEBUG: SIGNED OUT")
            }   catch   {
                print("DEBUG: FAILED TO SIGN OUT")
            }
        }
    
    //MARK: - Helpers
    func configureUI() {

        collectionView.backgroundColor = .black
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "032-lock-1"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleLogout))
        
        navigationItem.title = "Feed"
    }
}
//MARK: - DataSoure
extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
    Int {
        return 5
        }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}
//MARK: - CellSize
extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}
