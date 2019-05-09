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

class AddProductionViewController: ProductionRepositoryViewController {
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "添加作品"
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let submitResult: Observable<Result<Production>> = submitAction
            .flatMapLatest { [weak self] _ in
                NetworkService.shared.addProduction(self?.dataSource.value ?? Production(), self?.addProductionImageRequest.value ?? ProductionImageRequest())
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
        
        scrollerView.rx.didScroll
            .bind{ [weak self] in guard let `self` = self else { return }
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
    }
}



