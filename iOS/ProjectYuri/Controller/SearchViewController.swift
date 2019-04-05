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
import ZSUtils

class SearchViewController: ZSViewController {
    
    let tableView: UITableView = {
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
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.returnKeyType = .done
        return searchBar
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: ["全部", "游戏", "动画", "漫画", "小说"])
        groupBtn.selectedSegmentIndex = 0
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    let emptyView = ZSEmptyView()
    
    override func buildSubViews() {
        title = "搜索"
        navigationItem.titleView = searchBar
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.addSubview(groupBtn)
    }
    
    override func makeConstraints() -> Void {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
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
    
    let newRepositoriesRequest = BehaviorRelay(value: RepositoriesRequest())
    
    let moreRepositoriesRequest = BehaviorRelay(value: RepositoriesRequest(page: 2))
    
    let dataSource = BehaviorRelay(value: Repositories())
    
    override func bindViewModel() {
        let groupBtnAction: Observable<Int> = groupBtn.rx.selectedSegmentIndex
            .asObservable()
            .distinctUntilChanged()
            .share()
        
        let filteredDataFromGroupBtnAction: Observable<[Repository]> = groupBtnAction
            .flatMap{ [weak self] in
                self?.filteredItems($0, self?.dataSource.value.items ?? [Repository]()) ?? Observable.of([Repository]())
            }

        let filteredDataFromDataSource: Observable<[Repository]> = dataSource
            .skip(2)
            .map{ $0.items }
            .flatMap{ [weak self] in
                self?.filteredItems(self?.groupBtn.selectedSegmentIndex ?? 0, $0) ?? Observable.of([Repository]())
            }
            
        Observable.merge(
            filteredDataFromGroupBtnAction,
            filteredDataFromDataSource
            )
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
                self?.tableView.reloadData(withEmpty: self?.emptyView)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: { [weak self] in guard let `self` = self else { return }
                self.gotoProductionViewController(Observable.of($0))
            })
            .disposed(by: disposeBag)
        
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
        
        let newData:Observable<Repositories> = newRepositoriesRequest
            .skip(2)
            .flatMapLatest {
                NetworkService.shared.searchRepositories($0)
            }
            .share(replay: 1)
        
        let moreData:Observable<Repositories> = moreRepositoriesRequest
            .skip(1)
            .map{ [weak self] in guard let `self` = self else { return $0 }
                $0.page = self.dataSource.value.currentPage + 1
                return $0
            }
            .flatMapLatest {
                NetworkService.shared.searchRepositories($0)
            }
            .share(replay: 1)
        
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
        
        newData
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        moreData
            .map{ [weak self] in guard let `self` = self else { return $0 }
                return self.dataSource.value + $0
            }
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        newData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: { [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage = 1
            })
            .disposed(by: disposeBag)
        
        moreData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: { [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage += 1
            })
            .disposed(by: disposeBag)
        
        let searchAction: Observable<String> = searchBar.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
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
            .merge(
                searchBar.rx.searchButtonClicked.asObservable(),
                searchBar.rx.cancelButtonClicked.asObservable(),
                tableView.rx.didScroll.asObservable()
            )
            .bind { [weak self] _ in
                self?.searchBar.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        Observable
            .merge(searchAction, headerAction)
            .map{ RepositoriesRequest(query: $0) }
            .bind(to: newRepositoriesRequest)
            .disposed(by: disposeBag)
        
        footerAction
            .map{
                self.moreRepositoriesRequest.value.query = $0
                return self.moreRepositoriesRequest.value
            }
            .bind(to: moreRepositoriesRequest)
            .disposed(by: disposeBag)
        
        refrashAction
            .flatMap { [weak self] _ in
                Observable.of(self?.dataSource.value ?? Repositories())
            }
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
    
    func filteredItems(_ index: Int, _ items: [Repository]) -> Observable<[Repository]> {
        return Observable
            .from(items)
            .filter{ index == 0 ? true : $0.category == ProductionCategory.allCases[index-1] }
            .toArray()
    }
}

