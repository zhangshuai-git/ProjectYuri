//
//  AddProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddProductionViewController: ZSViewController {
    
    let scrollerContentView = UIView()
    let scrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        return scrollerView
    }()
    
    let nameTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品中文名"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let originNameTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品原名"
        return label
    }()
    
    let originNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let despTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品简介"
        return label
    }()
    
    let despTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    let catalogTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品类别"
        return label
    }()
    
    let groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: ["游戏", "动画", "漫画", "小说"])
        groupBtn.selectedSegmentIndex = 0
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    let imgTitleLab: UILabel = {
        let label = UILabel()
        label.text = "上传封面"
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
    
    let submittalBtn: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(scrollerView)
        scrollerView.addSubview(scrollerContentView)
        scrollerContentView.addSubview(nameTitleLab)
        scrollerContentView.addSubview(nameTextField)
        scrollerContentView.addSubview(originNameTitleLab)
        scrollerContentView.addSubview(originNameTextField)
        scrollerContentView.addSubview(despTitleLab)
        scrollerContentView.addSubview(despTextView)
        scrollerContentView.addSubview(catalogTitleLab)
        scrollerContentView.addSubview(groupBtn)
        scrollerContentView.addSubview(imgTitleLab)
        scrollerContentView.addSubview(imgBtn)
        scrollerContentView.addSubview(submittalBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        scrollerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        scrollerContentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        nameTitleLab.snp.makeConstraints { (make) in
            make.top.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.height.equalTo(20)
        }
        
        originNameTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        originNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(originNameTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.height.equalTo(20)
        }
        
        despTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(originNameTextField.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        despTextView.snp.makeConstraints { (make) in
            make.top.equalTo(despTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.height.equalTo(100)
        }
        
        catalogTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(despTextView.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(catalogTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        imgTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(groupBtn.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        imgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imgTitleLab.snp.bottom).offset(10)
            make.leading.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        submittalBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imgBtn.snp.bottom).offset(30)
            make.bottom.leading.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
    }
    
    let addProductionRequest = BehaviorRelay(value: AddProductionRequest())
    let addProductionImageRequest = BehaviorRelay(value: AddProductionImageRequest())
    
    override func bindViewModel() {
        super.bindViewModel()
        
        nameTextField.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.addProductionRequest.value.nameCN = $0
            }
            .disposed(by: disposeBag)
        
        originNameTextField.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.addProductionRequest.value.name = $0
            }
            .disposed(by: disposeBag)
        
        despTextView.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.addProductionRequest.value.desp = $0
            }
            .disposed(by: disposeBag)
        
        imgBtn.rx.tap
            .bind { [weak self] in guard let `self` = self else { return }
                let pm = MLDPhotoManager(self.imgBtn, withCameraImages: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.addProductionImageRequest.value.coverImg = image ?? UIImage()
                }, withAlbumArray: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.addProductionImageRequest.value.coverImg = image ?? UIImage()
                }, cancel: nil)
                pm?.maxPhotoCount = 1
                pm?.showAlert(self.imgBtn)
            }
            .disposed(by: disposeBag)
        
        submittalBtn.rx.tap
            .flatMapLatest {_ in
                NetworkService.shared.addProduction(self.addProductionRequest.value, self.addProductionImageRequest.value)
            }
            .bind {
                print($0.toJSON())
            }
            .disposed(by: disposeBag)
        
    }
}
