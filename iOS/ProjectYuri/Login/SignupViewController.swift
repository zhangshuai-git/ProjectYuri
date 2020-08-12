//
//  SignupViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/24.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ZSUtils

class SignupViewController: ZSViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.separatorStyle = .none
        tableView.zs.register(ProductionCell0.self)
        tableView.zs.register(ProductionCell3.self)
        return tableView
    }()
    
    let footerView: ProductionFooterView = {
        let footerView = ProductionFooterView()
        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return footerView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
        tableView.tableFooterView = footerView
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    let input = BehaviorRelay(value: User())
    let addProductionImageRequest = BehaviorRelay(value: ProductionImageRequest())
    
    lazy var dataSource: BehaviorRelay<[ProductionModel]> = BehaviorRelay(value: [
        ProductionModel(title: "用户名", content: self.input.value.username),
        ProductionModel(title: "密码", content: self.input.value.password),
        ProductionModel(title: "确认密码", content: self.input.value.password2),
        ProductionModel(title: "昵称", content: self.input.value.nickname),
        ProductionModel(title: "上传头像", coverUrl: self.input.value.avatarUrl),
        ])
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                switch row {
                case 0:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [unowned self] in self.input.value.username = $0.content }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 1:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [unowned self] in self.input.value.password = $0.content }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 2:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [unowned self] in self.input.value.password2 = $0.content }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 3:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [unowned self] in self.input.value.nickname = $0.content }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 4:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell3.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [unowned self] in self.addProductionImageRequest.value.coverImg = $0.image }
                        .disposed(by: cell.disposeBag)
                    return cell
                default: return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)
        
        let submitResult: Observable<Result<User>> = footerView.submittalBtn.rx.tap
            .filter{ [unowned self] in
                let valid = !self.input.value.username.isEmpty
                if !valid {self.showMessage("请输入用户名")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = !self.input.value.password.isEmpty
                if !valid {self.showMessage("请输入密码")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = !self.input.value.password2.isEmpty
                if !valid {self.showMessage("请再次输入密码")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = self.input.value.password == self.input.value.password2
                if !valid {self.showMessage("两次输入密码不一致")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = !self.input.value.nickname.isEmpty
                if !valid {self.showMessage("请输入昵称")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = self.addProductionImageRequest.value.coverImg != nil
                if !valid {self.showMessage("请上传头像")}
                return valid
            }
            .flatMapLatest { [unowned self] _ in
                NetworkService.shared.signup(self.input.value, self.addProductionImageRequest.value)
            }
            .share(replay: 1)
        
        submitResult
            .filter{$0.code == 0}
            .bind { [unowned self] _ in
                self.showMessage("添加成功", handler: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            .disposed(by: disposeBag)
        
        submitResult
            .filter{$0.code != 0}
            .bind { [unowned self] in self.showMessage($0.message) }
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .bind{ [unowned self] in self.view.endEditing(true) }
            .disposed(by: disposeBag)
        
    }
}
