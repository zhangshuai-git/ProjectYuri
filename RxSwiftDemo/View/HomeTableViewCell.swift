//
//  HomeTableViewCell.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

class HomeTableViewCell: BaseTableViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var detailLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var actionBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Owner", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override func buildSubViews() {
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
        contentView.addSubview(actionBtn)
    }
    
    override func makeConstraints() {
        titleLab.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.right.lessThanOrEqualTo(actionBtn.snp.left).offset(10)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.bottom.left.right.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        actionBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLab)
            make.top.right.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
    }
    
}

