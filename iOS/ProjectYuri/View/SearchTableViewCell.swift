//
//  HomeTableViewCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit

class SearchTableViewCell: ZSTableViewCell {
    
    let iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let originNameLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let categoryLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.main
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    override func buildSubViews() {
        contentView.addSubview(iconImg)
        contentView.addSubview(nameLab)
        contentView.addSubview(originNameLab)
        contentView.addSubview(contentLab)
        contentView.addSubview(categoryLab)
    }
    
    override func makeConstraints() {
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalTo(nameLab.snp.left).offset(-20)
            make.right.equalTo(originNameLab.snp.left).offset(-20)
            make.right.equalTo(contentLab.snp.left).offset(-20)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.right.lessThanOrEqualTo(categoryLab.snp.left).offset(10)
        }
        
        originNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(5)
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(originNameLab.snp.bottom).offset(10)
            make.bottom.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        categoryLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLab)
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 35, height: 20))
        }
        
    }
    
    // MARK: - dataSource
    
    let dataSource = BehaviorRelay(value: Repository())
    
    override func bindViewModel() {
        dataSource
            .bind { [weak self] in guard let `self` = self else { return }
                self.iconImg.sd_setImage(with: URL(string: $0.owner.avatarUrl))
                self.nameLab.text = $0.name
                self.originNameLab.text = $0.fullName
                self.contentLab.text = $0.desp
                self.categoryLab.text = $0.category?.displayValue
            }
            .disposed(by: disposeBag)
    }
    
}

