//
//  EasyThemeExchangeMethod.swift
//  beater
//
//  Created by sean on 2020/4/29.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit

extension UIView {
    private static var easyTheme_once: Bool = false
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



extension UIView {
    
    var backgroundColor: UIColor?{
        set{
            self.setValue(newValue, forKey: "backgroundColor")
            self.backgroundColorName =  newValue?.colorName
        }
        get{
            return self.value(forKeyPath: "backgroundColor") as? UIColor
        }
    }
    
    var tintColor :UIColor {
        set{
            self.setValue(newValue, forKey: "tintColor")
            self.tintColorName = newValue.colorName;
        }
        get{
            return self.value(forKeyPath: "tintColor") as! UIColor
        }
    }
}

extension UINavigationBar {
    var barTintColor:UIColor? {
        set{
            self.setValue(newValue, forKey: "barTintColor")
            self.barTintColorName = newValue?.colorName
        }
        get{
            return self.value(forKeyPath: "barTintColor") as? UIColor
        }
    }
}


var kTabBarbackgroundImage :Void?
extension UITabBar {
    var backgroundImage: UIImage? {
        
        set{
            self.setValue(newValue, forKey: "backgroundImage")
            self.backgroundImageName = newValue?.imageName
        }
        
        get{
            return self.value(forKeyPath: "backgroundImage") as? UIImage
        }
    }
    
    var backgroundImageName: String? {
        get {
            return objc_getAssociatedObject(self, &kTabBarbackgroundImage) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &kTabBarbackgroundImage, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}



///addTag
var KbackgroundColor: Void?
var KtintColor: Void?
var KbarTintColor: Void?
extension UIView {
    var backgroundColorName: String? {
        get {
            return objc_getAssociatedObject(self, &KbackgroundColor) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &KbackgroundColor, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    var tintColorName: String? {
        get {
            return objc_getAssociatedObject(self, &KtintColor) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &KtintColor, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
}


extension UINavigationBar {
    var barTintColorName: String? {
        get {
            return objc_getAssociatedObject(self, &KbarTintColor) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &KbarTintColor, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}


