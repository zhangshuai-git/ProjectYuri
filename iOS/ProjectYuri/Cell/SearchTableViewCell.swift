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
    
    lazy var dataSource = BehaviorRelay(value: Repository())
    
    lazy var iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var detailLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
//        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
//        label.numberOfLines = 0
        return label
    }()
    
//    lazy var actionBtn: UIButton = {
//        let button = UIButton()
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.cornerRadius = 5
//        button.layer.masksToBounds = true
//        button.layer.borderColor = UIColor.darkGray.cgColor
//        button.layer.borderWidth = 1
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        return button
//    }()
    
//    var isButtonActive: Bool = false {
//        willSet {
//            switch newValue {
//            case true:
//                actionBtn.setTitle("Unsubscribe", for: .normal)
//            case false:
//                actionBtn.setTitle("Subscribe", for: .normal)
//            }
//        }
//    }
    
    override func buildSubViews() {
        contentView.addSubview(iconImg)
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
        contentView.addSubview(contentLab)
//        contentView.addSubview(actionBtn)
    }
    
    override func makeConstraints() {
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalTo(titleLab.snp.left).offset(-20)
            make.right.equalTo(detailLab.snp.left).offset(-20)
            make.right.equalTo(contentLab.snp.left).offset(-20)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
//            make.right.lessThanOrEqualTo(actionBtn.snp.left).offset(10)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab.snp.bottom).offset(10)
            make.bottom.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
//        actionBtn.snp.makeConstraints { (make) in
//            make.centerY.equalTo(titleLab)
//            make.top.right.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
//            make.size.equalTo(CGSize(width: 90, height: 25))
//        }
    }
    
    override func bindViewModel() {
        dataSource
            .bind {
                [weak self] in guard let `self` = self else { return }
                self.iconImg.sd_setImage(with: URL(string: $0.owner.avatarUrl))
                self.titleLab.text = $0.name
                self.detailLab.text = $0.desp
                self.contentLab.text = $0.htmlUrl
//                self.isButtonActive = $0.isSubscribed
            }
            .disposed(by: disposeBag)
        
//        actionBtn.rx.tap
//            .asObservable()
//            .map({
//                [weak self] (_) -> Bool in guard let `self` = self else { return false }
//                self.isButtonActive.toggle()
//                return self.isButtonActive
//            })
//            .bind(onNext: {
//                [weak self] in guard let `self` = self else { return }
//                print($0)
//                self.dataSource.value.isSubscribed = $0
//                $0 ? DatabaseService.shared.add(repository: self.dataSource.value)
//                   : DatabaseService.shared.delete(repository: self.dataSource.value)
//            })
//            .disposed(by: disposeBag)
    }
}

