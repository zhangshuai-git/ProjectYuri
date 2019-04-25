//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ZSViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    func buildSubViews() -> Void { }
    func makeConstraints() -> Void { }
    func bindViewModel() -> Void { }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
}

extension ZSViewController {
    func gotoProductionViewController(_ data: Observable<Production>) {
        let vc = ProductionViewController()
        data.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoProfileContainerViewController() {
        let vc = ProfileContainerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoAddProductionViewController() {
        let vc = AddProductionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ZSViewController {
    func showMessage(_ msg: String?, handler: (() -> Void)? = nil) -> Void {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in handler?()}))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
