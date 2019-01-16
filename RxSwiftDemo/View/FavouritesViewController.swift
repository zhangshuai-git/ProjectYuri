//
//  FavouritesViewController.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class FavouritesViewController: BaseViewController {

    let viewModel = FavouritesViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(HomeTableViewCell.self)
        return tableView
    }()
    
    var favourites: [Repository]?
    
    override func buildSubViews() {
        self.title = "Favourites"
        view.addSubview(tableView)
    }
    
    override func makeConstraints() -> Void {
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    override func bindViewModel() {
        
        
    }
    
}
