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
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.placeholder = "例如:无夜国度"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        return textField
    }()
    
    let originNameTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品原名"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let originNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.placeholder = "例如:よるのないくに"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        return textField
    }()
    
    let despTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品简介"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let despTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.groupTableViewBackground
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let catalogTitleLab: UILabel = {
        let label = UILabel()
        label.text = "作品类别"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let categoryArray: [ProductionCategory] = ProductionCategory.allCases
    lazy var groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: categoryArray.map{$0.displayValue})
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    let imgTitleLab: UILabel = {
        let label = UILabel()
        label.text = "上传封面"
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
    
    let submittalBtn: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        title = "添加作品"
        view.backgroundColor = UIColor.white
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
            make.top.leading.right.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
        originNameTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        originNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(originNameTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
        despTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(originNameTextField.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        despTextView.snp.makeConstraints { (make) in
            make.top.equalTo(despTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(200)
        }
        
        catalogTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(despTextView.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(catalogTitleLab.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        imgTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(groupBtn.snp.bottom).offset(30)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        imgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imgTitleLab.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        submittalBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imgBtn.snp.bottom).offset(30)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 40, bottom: 40, right: 40))
            make.height.equalTo(40)
        }
        
    }
    
    let dataSource = BehaviorRelay(value: Production())
    let addProductionImageRequest = BehaviorRelay(value: ProductionImageRequest())
    
    override func bindViewModel() {
        super.bindViewModel()
        
        nameTextField.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.dataSource.value.nameCN = $0
            }
            .disposed(by: disposeBag)
        
        originNameTextField.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.dataSource.value.name = $0
            }
            .disposed(by: disposeBag)
        
        despTextView.rx.text.orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.dataSource.value.desp = $0
            }
            .disposed(by: disposeBag)
        
        groupBtn.rx.selectedSegmentIndex
            .filter{ [weak self] in guard let `self` = self else { return false }
                return $0 >= 0 && $0 < self.categoryArray.count
            }
            .bind{ [weak self] in guard let `self` = self else { return }
                self.dataSource.value.category = self.categoryArray[$0]
            }
            .disposed(by: disposeBag)
        
        imgBtn.rx.tap
            .bind { [weak self] in guard let `self` = self else { return }
                let pm = MLDPhotoManager(self.imgBtn, withCameraImages: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.addProductionImageRequest.value.coverImg = image
                }, withAlbumArray: { images in
                    let image = images?.first as? UIImage
                    self.imgBtn.setImage(image, for: .normal)
                    self.addProductionImageRequest.value.coverImg = image
                }, cancel: nil)
                pm?.maxPhotoCount = 1
                pm?.showAlert(self.imgBtn)
            }
            .disposed(by: disposeBag)
        
        let submitAction: Observable<Void> = submittalBtn.rx.tap
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.nameCN.isEmpty
                if !valid {self.showMessage("请输入作品中文名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.name.isEmpty
                if !valid {self.showMessage("请输入作品原名")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = !self.dataSource.value.desp.isEmpty
                if !valid {self.showMessage("请输入作品简介")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.dataSource.value.category != nil
                if !valid {self.showMessage("请选择作品类型")}
                return valid
            }
            .filter{ [weak self] in guard let `self` = self else { return false }
                let valid = self.addProductionImageRequest.value.coverImg != nil
                if !valid {self.showMessage("请上传封面图")}
                return valid
            }
        
        let submitResult: Observable<Result<Production>> = submitAction
            .flatMapLatest { [weak self] _ in
                NetworkService.shared.addProduction(self?.dataSource.value ?? Production(), self?.addProductionImageRequest.value ?? ProductionImageRequest())
            }
            .share(replay: 1)
            
        submitResult
            .filter{$0.code == 0}
            .bind { [weak self] _ in guard let `self` = self else { return }
                self.showMessage("添加成功", handler: { 
                    self.navigationController?.popViewController(animated: true)
                })
            }
            .disposed(by: disposeBag)
        
        submitResult
            .filter{$0.code != 0}
            .bind { [weak self] in guard let `self` = self else { return }
                self.showMessage($0.message)
            }
            .disposed(by: disposeBag)
        
        scrollerView.rx.didScroll
            .bind{ [weak self] in guard let `self` = self else { return }
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
    }
}



