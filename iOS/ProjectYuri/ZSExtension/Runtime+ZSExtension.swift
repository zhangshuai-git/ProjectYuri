//
//  Runtime+ZSExtension.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import Foundation

extension RuntimeHandler {
    open override class func handleLoad() {
        print("did call handleLoad!")
    }
    
    open override class func handleInitialize() {
        print("did call handleInitialize!")
    }
}
