//
//  EditProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/07.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditProductionViewController: ProductionRepositoryViewController {
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "编辑作品"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind{ [weak self] in guard let `self` = self else { return }
                self.nameTextField.text = $0.nameCN
                self.originNameTextField.text = $0.name
                self.despTextView.text = $0.desp
                if let category = $0.category {
                    self.groupBtn.selectedSegmentIndex = self.categoryArray.firstIndex(of: category)!
                }
                self.imgBtn.sd_setImage(with: URL(string: $0.coverUrl), for: .normal, completed: nil)
            }
            .disposed(by: disposeBag)
        
        let submitResult: Observable<Result<Production>> = submittalBtn.rx.tap
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.nameCN.isEmpty
                if !valid {self.showMessage("请输入作品中文名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.name.isEmpty
                if !valid {self.showMessage("请输入作品原名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.desp.isEmpty
                if !valid {self.showMessage("请输入作品简介")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.dataSource.value.category != nil
                if !valid {self.showMessage("请选择作品类型")}
                return valid
            }
            .flatMapLatest { [weak self] _ in
                NetworkService.shared.updateProduction(self?.dataSource.value ?? Production(), self?.addProductionImageRequest.value ?? ProductionImageRequest())
            }
            .share(replay: 1)
        
        submitResult
            .filter{$0.code == 0}
            .bind { [weak self] _ in guard let `self` = self else { return }
                self.showMessage("更新成功", handler: {
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
        
    }
}
