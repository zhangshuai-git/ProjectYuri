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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    let input = BehaviorRelay(value: User())
    let addProductionImageRequest = BehaviorRelay(value: ProductionImageRequest())
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let submitResult: Observable<Result<User>> = footerView.submittalBtn.rx.tap
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.username.isEmpty
                if !valid {self.showMessage("请输入用户名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.password.isEmpty
                if !valid {self.showMessage("请输入密码")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.password2.isEmpty
                if !valid {self.showMessage("请再次输入密码")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.input.value.password == self.input.value.password2
                if !valid {self.showMessage("两次输入密码不一致")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.nickname.isEmpty
                if !valid {self.showMessage("请输入昵称")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.addProductionImageRequest.value.coverImg != nil
                if !valid {self.showMessage("请上传头像")}
                return valid
            }
            .flatMapLatest { [weak self] _ in
                NetworkService.shared.signup(self?.input.value ?? User(), self?.addProductionImageRequest.value ?? ProductionImageRequest())
            }
            .share(replay: 1)
        
        submitResult
            .filter{$0.code == 0}
            .bind { [weak self] _ in guard let `self` = self else { return }
                self.showMessage("添加成功", handler: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            .disposed(by: disposeBag)
        
        submitResult
            .filter{$0.code != 0}
            .bind { [weak self] in guard let `self` = self else { return }
                self.showMessage($0.message)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .bind{ [weak self] in guard let `self` = self else { return }
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Index: Int, CaseIterable {
        case username
        case password
        case password2
        case nickname
        case avatar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Index.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let index = Index(rawValue: indexPath.row) else {
            fatalError("Invalid index \(indexPath)")
        }
        switch index {
        case .username:
            let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
            Observable.of(ProductionModel(title: "用户名", content: self.input.value.username))
                .bind(to: cell.input)
                .disposed(by: cell.disposeBag)
            cell.output
                .bind{ [weak self] in guard let `self` = self else { return }
                    self.input.value.username = $0.content
                }
                .disposed(by: cell.disposeBag)
            return cell
        case .password:
            let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
            Observable.of(ProductionModel(title: "密码", content: self.input.value.password))
                .bind(to: cell.input)
                .disposed(by: cell.disposeBag)
            cell.output
                .bind{ [weak self] in guard let `self` = self else { return }
                    self.input.value.password = $0.content
                }
                .disposed(by: cell.disposeBag)
            return cell
        case .password2:
            let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
            Observable.of(ProductionModel(title: "再次输入密码", content: self.input.value.password2))
                .bind(to: cell.input)
                .disposed(by: cell.disposeBag)
            cell.output
                .bind{ [weak self] in guard let `self` = self else { return }
                    self.input.value.password2 = $0.content
                }
                .disposed(by: cell.disposeBag)
            return cell
        case .nickname:
            let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
            Observable.of(ProductionModel(title: "昵称", content: self.input.value.nickname))
                .bind(to: cell.input)
                .disposed(by: cell.disposeBag)
            cell.output
                .bind{ [weak self] in guard let `self` = self else { return }
                    self.input.value.nickname = $0.content
                }
                .disposed(by: cell.disposeBag)
            return cell
        case .avatar:
            let cell = tableView.zs.dequeueReusableCell(ProductionCell3.self, for: indexPath)
            Observable.of(ProductionModel(title: "上传头像", coverUrl: self.input.value.avatarUrl))
                .bind(to: cell.input)
                .disposed(by: cell.disposeBag)
            cell.output
                .bind{ [weak self] in guard let `self` = self else { return }
                    self.addProductionImageRequest.value.coverImg = $0.image
                }
                .disposed(by: cell.disposeBag)
            return cell
        }
    }
    

}
