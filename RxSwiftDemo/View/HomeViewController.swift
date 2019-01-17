//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
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
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var resultLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var actionBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Favourites", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var emptyView: ZSEmptyView = {
        let emptyView = ZSEmptyView(message: "请输入关键字\n实时搜索GitHub上的repositories\n下拉列表刷新数据，上拉加载更多数据\n点击条目查看详情，点击Owner查看作者信息")
        emptyView.backgroundColor = UIColor.white
        return emptyView
    }()
    
    override func buildSubViews() {
        navigationItem.titleView = searchBar
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.addSubview(resultLab)
        topView.addSubview(actionBtn)
    }
    
    override func makeConstraints() -> Void {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.equalToSuperview()
        }
        
        resultLab.snp.makeConstraints { (make) in
            make.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
            make.centerY.equalTo(actionBtn)
        }
        
        actionBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.left.equalTo(resultLab.snp.right).offset(20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    override func bindViewModel() {
        viewModel.dataSourceCount
            .bind(to: resultLab.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dataSource
            .skip(1)
            .map{ $0.items }
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                Observable.of(element).bind(to: cell.viewModel.dataSource).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.dataSource
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.tableView.zs.reloadData(withEmpty: self.emptyView)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: {
                [weak self] in guard let `self` = self else { return }
                self.gotoOwnerViewController(Observable.of($0.owner))
            })
            .disposed(by: disposeBag)
        
        viewModel.newData
            .map{ _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        Observable
            .merge(viewModel.newData.map(footerState), viewModel.moreData.map(footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: disposeBag)
        
        actionBtn.rx.tap
            .asObservable()
            .bind {
                [weak self] in guard let `self` = self else { return }
                self.gotoFavouritesViewController(self.viewModel.favourites.asObservable())
            }
            .disposed(by: disposeBag)
        
        let searchAction:Observable<String> = searchBar.rx.text.orEmpty
            .throttle(2.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        let headerAction:Observable<String> = tableView.mj_header.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }
        
        let footerAction:Observable<String> = tableView.mj_footer.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }
        
        viewModel.activate((searchAction: searchAction, headerAction: headerAction, footerAction: footerAction))
    }
}

extension HomeViewController {
    func footerState(_ repositories: Repositories) -> RxMJRefreshFooterState {
        if repositories.items.count == 0 { return .hidden }
        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
    }
    
    func gotoOwnerViewController(_ owner: Observable<RepositoryOwner>) {
        let vc = OwnerViewController()
        owner.bind(to: vc.viewModel.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoFavouritesViewController(_ favourites: Observable<[Repository]>) {
        let vc = FavouritesViewController()
        favourites.bind(to: vc.viewModel.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
}

