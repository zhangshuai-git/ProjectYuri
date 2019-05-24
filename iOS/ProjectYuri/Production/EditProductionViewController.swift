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

class EditProductionViewController: ProductionViewController {
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "编辑作品"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let submitResult: Observable<Result<Production>> = footerView.submittalBtn.rx.tap
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.nameCN.isEmpty
                if !valid {self.showMessage("请输入作品中文名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.name.isEmpty
                if !valid {self.showMessage("请输入作品原名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.input.value.desp.isEmpty
                if !valid {self.showMessage("请输入作品简介")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.input.value.category != nil
                if !valid {self.showMessage("请选择作品类型")}
                return valid
            }
            .flatMapLatest { [weak self] _ in
                NetworkService.shared.updateProduction(self?.input.value ?? Production(), self?.addProductionImageRequest.value ?? ProductionImageRequest())
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
