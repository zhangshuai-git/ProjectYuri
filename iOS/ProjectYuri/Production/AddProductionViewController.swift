//
//  AddProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddProductionViewController: ProductionViewController {
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "添加作品"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let submitResult: Observable<Result<Production>> = footerView.submittalBtn.rx.tap
            .filter{ [unowned self] in
                let valid = !self.input.value.nameCN.isEmpty
                if !valid {self.showMessage("请输入作品中文名")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = !self.input.value.name.isEmpty
                if !valid {self.showMessage("请输入作品原名")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = !self.input.value.desp.isEmpty
                if !valid {self.showMessage("请输入作品简介")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = self.input.value.category != nil
                if !valid {self.showMessage("请选择作品类型")}
                return valid
            }
            .filter{ [unowned self] in
                let valid = self.addProductionImageRequest.value.coverImg != nil
                if !valid {self.showMessage("请上传封面图")}
                return valid
            }
            .flatMapLatest { [unowned self] _ in
                NetworkService.shared.addProduction(self.input.value, self.addProductionImageRequest.value)
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
            .bind { [unowned self] in
                self.showMessage($0.message)
            }
            .disposed(by: disposeBag)
    }
}



