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

class EditProductionViewController: AddProductionViewController {
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "编辑作品"
    }
    
    let dataSource = BehaviorRelay(value: Production())
    
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
        
    }
}
