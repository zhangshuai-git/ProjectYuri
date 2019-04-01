//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductionCellModel<T> {
    var isExpanded: Bool = false
    var data: T
    
    init(_ data: T) {
        self.data = data
    }
}

class ProductionCell0: ZSExpandableCell {
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        expandBtn.backgroundColor = .clear
        
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    let dataSource = PublishRelay<ProductionCellModel<Repository>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.desp) \($0.desp) \($0.desp) \($0.desp) \n\n\($0.desp) \($0.desp) \($0.desp) \($0.desp)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
        
        dataSource
            .bind { [weak self] in guard let `self` = self else { return }
                self.isExpanded = $0.isExpanded
            }
            .disposed(by: disposeBag)
    }

}

class ProductionCell1: ZSExpandableCell {
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        expandBtn.backgroundColor = .clear
        
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    let dataSource = PublishRelay<ProductionCellModel<Repository>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
        
        dataSource
            .bind { [weak self] in guard let `self` = self else { return }
                self.isExpanded = $0.isExpanded
            }
            .disposed(by: disposeBag)
    }
    
}

class ProductionCell2: ZSTableViewCell {
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = "点击查看详细"
        label.numberOfLines = 0
        return label
    }()
    
    let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(name: "ipad_player_setup_arrow")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        contentView.addSubview(contentLab)
        contentView.addSubview(arrowImg)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(contentLab.snp.right).offset(10)
            make.centerY.equalTo(contentLab)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
    }
    
    let dataSource = PublishRelay<ProductionCellModel<Repository>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}

class ProductionCell3: ZSTableViewCell {
    
    let moreBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("更多")
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(name: "ipad_player_setup_arrow")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    var characterArray: [ZSCharacterView] = {
        var arr = [ZSCharacterView]()
        for _ in 0..<6 {
            let view = ZSCharacterView()
            view.iconImg.backgroundColor = UIColor.random
            arr.append(view)
        }
        return arr
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        contentView.addSubview(moreBtn)
        contentView.addSubview(arrowImg)
        contentView.addSubview(mainView)
        characterArray.forEach { mainView.addSubview($0) }
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 25, height: 15))
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(moreBtn.snp.right)
            make.centerY.equalTo(moreBtn)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        mainView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.top.equalTo(moreBtn.snp.bottom).offset(10)
        }
        
        characterArray.snp.distributeSudokuViews(fixedLineSpacing: 10, fixedInteritemSpacing: 10, warpCount: 2)
        
    }
    
    let dataSource = PublishRelay<ProductionCellModel<Repository>>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}


