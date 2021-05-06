//
//  CommentController.swift
//  project_wayward
//
//  Created by Ray Decker Jr on 5/6/21.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentController: UICollectionViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

// MARK: - Helper

func configureCollectionView() {
    collectionView.backgroundColor = .black
    navigationItem.title = "Comments"
    collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    }

}
// MARK: - Data Source

extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
}
