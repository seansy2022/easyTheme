//
//  EasyThemeExchangeMethod.swift
//  beater
//
//  Created by sean on 2020/4/29.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
var easyTheme_once: Bool = false
extension UIView {
        static func initializeMethod() {
        guard easyTheme_once == false else{ return }
        easyTheme_once = true
        let originalSelector = #selector(UIView.didMoveToSuperview)
        let swizzledSelector = #selector(UIView.ex_didMoveToSuperview)
        
        let originalMethod = class_getInstanceMethod(UIView.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector)
        if let swizzledM = swizzledMethod {
            let didAddMethod: Bool =  class_addMethod(UIView.self, originalSelector, method_getImplementation(swizzledM), method_getTypeEncoding(swizzledM))
            if didAddMethod {
                class_replaceMethod(UIView.self, swizzledSelector, method_getImplementation(swizzledM), method_getTypeEncoding(swizzledM))
            }else {
                method_exchangeImplementations(originalMethod!, swizzledM)
            }
        }
    }
}

protocol UIViewExchangeDidMoveToSuperview {
    func ex_didMoveToSuperview()
}

extension UIView : UIViewExchangeDidMoveToSuperview {
    @objc func ex_didMoveToSuperview() {
        ex_didMoveToSuperview()
        EasyThemeManger.addNoticeView(view: self)
    }
}
