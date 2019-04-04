//
//  UICollectionView+ZSExtension.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

extension ZSExtension where Target: UICollectionView {
    func register(_ cellClass: AnyClass?) {
        guard let cellClass = cellClass else {
            fatalError("register cell failed")
        }
        target.register(cellClass, forCellWithReuseIdentifier: cellClass.description())
    }
    
    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let cellClass: AnyClass = cellClass as? AnyClass ?? UITableViewCell.self
        return target.dequeueReusableCell(withReuseIdentifier: cellClass.description(), for: indexPath) as! T
    }
}
