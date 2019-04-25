//
//  ProductionHeaderView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductionHeaderView: ZSView {
    
    let dataSource = PublishRelay<Production>()
    
    let iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(iconImg)
        addSubview(nameLab)
        addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.bottom.lessThanOrEqualTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.top.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(iconImg.snp.right).offset(10)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.top.equalTo(nameLab.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind { [weak self] in guard let `self` = self else { return }
                self.iconImg.sd_setImage(with: URL(string: $0.coverUrl))
                self.nameLab.text = $0.name
                self.contentLab.text = $0.desp
            }
            .disposed(by: disposeBag)
    }

}

class ProductionSectionHeaderView: ZSView {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        backgroundColor = UIColor.gray
        addSubview(titleLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        titleLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
            make.height.equalTo(20)
        }
    }
    
    let dataSource = PublishRelay<String>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind(to: titleLab.rx.text)
            .disposed(by: disposeBag)
    }
    
}
