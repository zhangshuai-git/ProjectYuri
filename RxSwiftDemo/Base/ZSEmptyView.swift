//
//  ZSEmptyView.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/20.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class ZSEmptyView: UIView {
    
    lazy var iconImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var messageLab: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var textFont: UIFont {
        get { return messageLab.font }
        set {
            messageLab.font = newValue
        }
    }
    
    init(image: UIImage? = nil, message: String? = nil) {
        super.init(frame: CGRect.zero)
        
        buildSubViews()
        makeConstraints()
        setupViews(with: image, message: message)
    }
    
    func buildSubViews() {
        backgroundColor = UIColor.white
        addSubview(iconImg)
        addSubview(messageLab)
    }
    
    func makeConstraints() {
        iconImg.snp.makeConstraints({ make in
            make.top.left.greaterThanOrEqualTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.bottom.right.lessThanOrEqualTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        })
        
        messageLab.snp.makeConstraints({ make in
            make.top.left.greaterThanOrEqualTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.bottom.right.lessThanOrEqualTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImg.snp.bottom).offset(20)
        })
    }
    
    func setupViews(with image: UIImage? = nil, message: String? = nil) {
        if image != nil {
            iconImg.image = image
        } else {
            iconImg.image = UIImage(named: "index_default_stats")
            iconImg.backgroundColor = UIColor.white
        }
        
        if message != nil {
            messageLab.text = message
        } else {
            messageLab.text = "空  空  如  也"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

