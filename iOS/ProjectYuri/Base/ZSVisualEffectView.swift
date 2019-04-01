//
//  ZSVisualEffectView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/01.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSVisualEffectView: ZSView {
    
    let backgroundImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let visualView: UIVisualEffectView = {
        var blurEffect = UIBlurEffect(style: .dark)
        var visualView = UIVisualEffectView(effect: blurEffect)
        return visualView
    }()

    override func buildSubViews() {
        super.buildSubViews()
        addSubview(backgroundImg)
        addSubview(visualView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        backgroundImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        visualView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
