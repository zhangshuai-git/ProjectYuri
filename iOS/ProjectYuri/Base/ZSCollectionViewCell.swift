//
//  ZSCollectionViewCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ZSCollectionViewCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bindViewModel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildSubViews() { }
    func makeConstraints() { }
    func bindViewModel() { }
    
    deinit {
        print("deinit \(self)")
    }
}
