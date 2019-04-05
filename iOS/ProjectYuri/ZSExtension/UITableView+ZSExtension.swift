//
//  UITableView+Extension.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/12/04.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

extension ZSExtension where Target: UITableView {
    func register(_ cellClass: AnyClass?) {
        guard let cellClass = cellClass else {
            fatalError("register cell failed")
        }
        target.register(cellClass, forCellReuseIdentifier: cellClass.description())
    }
    
    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let cellClass: AnyClass = cellClass as? AnyClass ?? UITableViewCell.self
        return target.dequeueReusableCell(withIdentifier: cellClass.description(), for: indexPath) as! T
    }
}
