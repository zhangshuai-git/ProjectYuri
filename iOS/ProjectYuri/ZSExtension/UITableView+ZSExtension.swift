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
    
    func reloadData(withEmpty emptyView: UIView?) {
        target.reloadData()
        var isEmpty = true
        var sectionCount: Int = 1
        if target.dataSource?.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) ?? false {
            sectionCount = target.dataSource?.numberOfSections?(in: target) ?? 1
        }
        for i in 0..<sectionCount {
            var rowCount: Int = 0
            if target.dataSource?.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) ?? false {
                rowCount = target.dataSource?.tableView(target, numberOfRowsInSection: i) ?? 0
            }
            if rowCount != 0 {
                isEmpty = false
                break
            }
        }
        if isEmpty {
            #if m_UseFooterView
            emptyView?.frame = target.bounds
            target.tableFooterView = emptyView
            #else
            target.backgroundView = emptyView
            #endif
        } else {
            #if m_UseFooterView
            target.tableFooterView = nil
            #else
            target.backgroundView = nil
            #endif
        }
    }
}
