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
    
    let dataSource = PublishRelay<MeModel>()

    func setData(data: MeModel) {
        self.titleLab.text = data.title
        self.detailLab.text = data.desp
        self.accessoryType = data.selectedAction != nil ? .disclosureIndicator : .none
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
    }
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let detailLab: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        titleLab.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(titleLab.snp.right).offset(10)
            make.right.top.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
}
