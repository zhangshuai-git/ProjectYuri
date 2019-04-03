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
        NSLog("navigationController.viewControllers.count = %@", NSNumber(value: navigationController?.viewControllers.count ?? 0))
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            //        self.leftBarButtonItem = [self createdBarButtonWithImageName:@"returin_icon" action:@selector(back)];
            leftBarButtonItem = UIBarButtonItem(target: self, action: #selector(self.back), image: UIImage(named: "returin_icon"))
        }
        
        view.backgroundColor = UIColor.groupTableViewBackground
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    func buildSubViews() -> Void { }
    func makeConstraints() -> Void { }
    func bindViewModel() -> Void { }
    
    deinit {
        print("\(self) deinit")
    }
    
}

extension ZSViewController {
    func gotoProductionViewController(_ data: Observable<Repository>) {
        let vc = ProductionViewController()
        data.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func gotoProfileViewController() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func gotoOwnerViewController(_ data: Observable<RepositoryOwner>) {
        let vc = OwnerViewController()
        data.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoFavouritesViewController(_ data: Observable<[Repository]>) {
        let vc = FavouritesViewController()
        data.bind(to: vc.dataSource).disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }

}
