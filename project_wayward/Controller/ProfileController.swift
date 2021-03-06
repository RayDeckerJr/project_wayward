//
//  ProfileController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 4/27/21.
//

import UIKit
 
private let cellIdentifer = "ProfileCell"
private let headerIdentifer = "ProfileHeader"


class ProfileController : UICollectionViewController {
    
    //MARK: - Properties
    private var user: User
    private var posts = [Post]()
    
    
    
    //MARK: - Lifecycle
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchUserPost()
    }
    //MARK: - API
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) {isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid){ stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserPost(){
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers
    func configureCollectionView() {
        collectionView.reloadData()
        collectionView.backgroundColor = .black
        navigationItem.title = user.username
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifer)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifer)
    }
}


    //MARK: - VIEW DATA SOURCE

extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
                                    IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for:
                                                        indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifer, for: indexPath) as! ProfileHeader
      
            header.viewModel = ProfileHeaderViewModel(user: user)
            header.delegate = self
        return header
    }
}
//MARK: - VIEW DATA Delegate
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - VIEW DATA SOURCE Flow Layout
extension ProfileController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2)/3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
// MARK: - ProfileHeader Delegate
extension ProfileController: ProfileHeaderDelegate{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser{
            
        }else if user.isFollowed{
            UserService.unfollow(uid: user.uid) {error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.follow(uid: user.uid) {error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
