//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ProfileViewController: ZSViewController {

    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.register(PurchaseCell.self, forCellWithReuseIdentifier: NSStringFromClass(PurchaseCell.self.self))
        return collectionView
    }()
}
