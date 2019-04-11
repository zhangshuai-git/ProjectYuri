//
//  MeCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MeCell: ZSTableViewCell {

    override func buildSubViews() {
        super.buildSubViews()
        accessoryType = .disclosureIndicator
    }
    
    let dataSource = PublishRelay<MeCellModel>()

    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind{ [weak self] in
                self?.textLabel?.text = $0.title
            }
            .disposed(by: disposeBag)
    }
}
