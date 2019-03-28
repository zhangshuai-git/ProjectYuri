//
//  ViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class SearchViewController: ZSViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(SearchTableViewCell.self)
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: ["全部", "游戏", "动画", "漫画", "小说"])
        groupBtn.selectedSegmentIndex = 0
        groupBtn.tintColor = UIColor(hex: MAIN_COLOR)
//        groupBtn.style = .clear
        return groupBtn
    }()
    
//    lazy var resultLab: UILabel = {
//        let label = UILabel()
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
    
//    lazy var actionBtn: UIButton = {
//        let button = UIButton()
//        button.setTitle("Favourites", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.cornerRadius = 5
//        button.layer.masksToBounds = true
//        button.layer.borderColor = UIColor.darkGray.cgColor
//        button.layer.borderWidth = 1
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        return button
//    }()
    
    lazy var emptyView = ZSEmptyView(message: "xxx")
    
    override func buildSubViews() {
//        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.titleView = searchBar
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.addSubview(groupBtn)
//        topView.addSubview(resultLab)
//        topView.addSubview(actionBtn)
        
//        let height: CGFloat = searchBar.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        searchBar.frame = CGRect(x: 0, y: 0, width: 0, height: height)
//        tableView.tableHeaderView = searchBar
    }
    
    override func makeConstraints() -> Void {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
//        resultLab.snp.makeConstraints { (make) in
//            make.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
//            make.height.equalTo(30)
//            make.centerY.equalTo(actionBtn)
//        }
//
//        actionBtn.snp.makeConstraints { (make) in
//            make.top.right.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
//            make.size.equalTo(CGSize(width: 80, height: 30))
//            make.left.equalTo(resultLab.snp.right).offset(20)
//        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
    override func updateViewConstraints() {
        if searchBar.showsCancelButton {
            groupBtn.snp.remakeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
                make.height.equalTo(30)
            }
        } else {
            groupBtn.snp.remakeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets.zero)
                make.height.equalTo(0)
            }
        }
        super.updateViewConstraints()
    }
    
    // MARK: - dataSource
    
    private lazy var newRepositoriesParams = BehaviorRelay(value: RepositoriesParams())
    
    private lazy var moreRepositoriesParams = BehaviorRelay(value: RepositoriesParams(page: 2))
    
//    lazy var favourites = BehaviorRelay(value: [Repository]())
    
    lazy var newData:Observable<Repositories> = newRepositoriesParams
        .skip(2)
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
//        .map({
//            [weak self] in guard let `self` = self else { return $0 }
//            return self.synchronizeSubscription($0)
//        })
        .share(replay: 1)
    
    lazy var moreData:Observable<Repositories> = moreRepositoriesParams
        .skip(1)
        .map{
            [weak self] in guard let `self` = self else { return $0 }
            $0.page = self.dataSource.value.currentPage + 1
            return $0
        }
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
//        .map({
//            [weak self] in guard let `self` = self else { return $0 }
//            return self.synchronizeSubscription($0)
//        })
        .share(replay: 1)
    
    lazy var dataSource = BehaviorRelay(value: Repositories())
    
//    lazy var dataSourceCount = Observable.merge(
//        dataSource.filter{ $0.totalCount > 0 }.map{ "共有 \($0.totalCount) 个结果" },
//        dataSource.filter{ $0.totalCount == 0 }.map{ _ in "未搜索到结果或请求太频繁请稍后再试" },
//        newRepositoriesParams.filter{ $0.query.isEmpty }.map{ _ in "" },
//        moreRepositoriesParams.filter{ $0.query.isEmpty }.map{ _ in "" }
//        ).skip(4)
    
    override func bindViewModel() {
//        dataSourceCount
//            .bind(to: resultLab.rx.text)
//            .disposed(by: disposeBag)
        
        dataSource
            .skip(2)
            .map{ $0.items }
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(SearchTableViewCell.self, for: IndexPath(row: row, section: 0))
                Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        dataSource
            .map { $0.totalCount == 0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.zs.reloadData(withEmpty: self?.emptyView)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: {
                [weak self] in guard let `self` = self else { return }
                self.gotoOwnerViewController(Observable.of($0.owner))
            })
            .disposed(by: disposeBag)
        
        newData
            .map{ _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        Observable
            .merge(newData.map(footerState), moreData.map(footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: disposeBag)
        
//        actionBtn.rx.tap
//            .asObservable()
//            .bind {
//                [weak self] in guard let `self` = self else { return }
//                self.gotoFavouritesViewController(self.favourites.asObservable())
//            }
//            .disposed(by: disposeBag)
        
        searchBar.rx.textDidBeginEditing
            .asObservable()
            .bind { [weak self] in guard let `self` = self else { return }
                self.searchBar.showsCancelButton = true
                self.view.setNeedsUpdateConstraints()
            } 
            .disposed(by: disposeBag)
        
        searchBar.rx.textDidEndEditing
            .asObservable()
            .bind { [weak self] in guard let `self` = self else { return }
                self.searchBar.showsCancelButton = false
                self.view.setNeedsUpdateConstraints()
            }
            .disposed(by: disposeBag)
        
        let searchAction: Observable<String> = searchBar.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .share()
        
        let groupBtnAction: Observable<Int> = groupBtn.rx.selectedSegmentIndex
            .asObservable()
            .distinctUntilChanged()
            .share()
        
        let headerAction: Observable<String> = tableView.mj_header.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }
            .share()
        
        let footerAction: Observable<String> = tableView.mj_footer.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }
            .share()
        
        let refrashAction: Observable<Void> = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .asObservable()
            .map { _ in () }
            .share()
        
        Observable
            .merge(searchAction.map{_ in }.skip(1), searchBar.rx.cancelButtonClicked.asObservable(), tableView.rx.didScroll.asObservable())
            .bind { [weak self] _ in
                self?.searchBar.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        groupBtnAction
            .bind {
                print("selected \($0)")
            }
            .disposed(by: disposeBag)
        
        Observable
            .merge(searchAction, headerAction)
            .map{ RepositoriesParams(query: $0) }
            .bind(to: newRepositoriesParams)
            .disposed(by: disposeBag)
        
        footerAction
            .map{
                self.moreRepositoriesParams.value.query = $0
                return self.moreRepositoriesParams.value
            }
            .bind(to: moreRepositoriesParams)
            .disposed(by: disposeBag)
        
        newData
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        moreData
            .map{
                [weak self] in guard let `self` = self else { return $0 }
                return self.dataSource.value + $0
            }
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        newData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage = 1
            })
            .disposed(by: disposeBag)
        
        moreData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage += 1
            })
            .disposed(by: disposeBag)
        
//        DatabaseService.shared.repositories
//            .bind(to: favourites)
//            .disposed(by: disposeBag)
        
        refrashAction
            .flatMap { [weak self] _ in
                Observable.of(self?.dataSource.value ?? Repositories())
            }
//            .map({
//                [weak self] in guard let `self` = self else { return $0 }
//                return self.synchronizeSubscription($0)
//            })
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
            .bind(to: dataSource)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    func footerState(_ repositories: Repositories) -> RxMJRefreshFooterState {
        if repositories.items.count == 0 { return .hidden }
        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
    }
    
//    func synchronizeSubscription(_ repositories: Repositories) -> Repositories {
//        for repository in repositories.items {
//            for favouriteRepository in favourites.value {
//                repository.isSubscribed = repository.id == favouriteRepository.id
//                if repository.isSubscribed { break }
//            }
//        }
//        return repositories
//    }
}

