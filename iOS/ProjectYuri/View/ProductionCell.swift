//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/13.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductionCell: ZSTableViewCell {
    let input = PublishRelay<ProductionModel>()
    let output = PublishRelay<ProductionModel>()
}

class ProductionCell0: ProductionCell {

    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        return textField
    }()

    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textField)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                self.textField.text = $0.content
                self.textField.placeholder = $0.detail
            }
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ ProductionModel(content: $0) }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}

class ProductionCell1: ProductionCell {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.groupTableViewBackground
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(200)
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                self.textView.text = $0.content
            }
            .disposed(by: disposeBag)
        
        textView.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ ProductionModel(content: $0) }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}

class ProductionCell2: ProductionCell {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let categoryArray: [ProductionCategory] = ProductionCategory.allCases
    lazy var groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: categoryArray.map{$0.displayValue})
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(groupBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                if let category = $0.category {
                    self.groupBtn.selectedSegmentIndex = self.categoryArray.firstIndex(of: category)!
                }
            }
            .disposed(by: disposeBag)
        
        groupBtn.rx.selectedSegmentIndex
            .filter{ [weak self] in guard let `self` = self else { return false }
                return $0 >= 0 && $0 < self.categoryArray.count
            }
            .map{ ProductionModel(category: self.categoryArray[$0]) }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}

class ProductionCell3: ProductionCell {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imgBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.main, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "taking_pictures"), for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(imgBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        imgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.bottom.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                self.imgBtn.sd_setImage(with: URL(string: $0.coverUrl), for: .normal, completed: nil)
            }
            .disposed(by: disposeBag)
        
        imgBtn.rx.tap
            .bind { [weak self] in guard let `self` = self else { return }
                let pm = MLDPhotoManager(self.imgBtn, withCameraImages: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.output.accept(ProductionModel(image: image))
                }, withAlbumArray: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.output.accept(ProductionModel(image: image))
                }, cancel: nil)
                pm?.maxPhotoCount = 1
                pm?.showAlert(self.imgBtn)
            }
            .disposed(by: disposeBag)
        
    }
}
