//
//  UIViewWithTitleAndContent.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import SnapKit

class ZSExpandableCell: ZSTableViewCell {
    
    var fixedHeight: CGFloat = 100 {
        willSet {
            setNeedsUpdateConstraints()
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let expandableView: UIView = {
        let view = UIView()
        return view
    }()
    
    let expandBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    var isExpanded: Bool = false {
        willSet {
            switch newValue {
            case true:
                expandBtn.setTitle("收起", for: .normal)
            case false:
                expandBtn.setTitle("展开", for: .normal)
            }
            setNeedsUpdateConstraints()
        }
    }

    override func buildSubViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(expandBtn)
        containerView.addSubview(mainView)
        mainView.addSubview(expandableView)
    }
    
    override func makeConstraints() {
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(fixedHeight)
        }
        
        expandBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 20))
            make.size.equalTo(CGSize(width: 35, height: 20))
        }
        
        mainView.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        expandableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func updateConstraints() {
        if isExpanded {
            containerView.snp.remakeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.bottom.equalTo(expandBtn.snp.top).offset(-5)
            }
            mainView.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        } else {
            containerView.snp.remakeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(fixedHeight)
                make.bottom.equalTo(expandBtn.snp.top).offset(-5)
            }
            mainView.snp.remakeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
        }
        super.updateConstraints()
    }
    
    let expandAction = PublishRelay<Bool>()
    
    override func bindViewModel() {
        expandBtn.rx.tap
            .asObservable()
            .map { [weak self] in guard let `self` = self else { return false }
                self.isExpanded.toggle()
                return self.isExpanded
            }
            .bind(to: expandAction)
            .disposed(by: disposeBag)
    }
    
}
