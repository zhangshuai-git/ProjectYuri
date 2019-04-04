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
        print("deinit \(self)")
    }
    
}

extension ZSViewController {
    func gotoProductionViewController(_ data: Observable<Repository>) {
        let vc = ProductionViewController()
        data.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func gotoProfileContainerViewController() {
        let vc = ProfileContainerViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    

}
