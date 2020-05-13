//
//  EasyTheme.swift
//  beater
//
//  Created by sean on 2020/4/29.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit

public class EasyThemeManger {
    public private(set) var themeType: String?
    private(set) var themeData: EasyThemeDataProtocol?
    private(set) var themeDatas: [EasyThemeDataProtocol] = Array.init()
    private var weakTable: NSHashTable<UIView> = NSHashTable.init(options: .weakMemory)
    static private let  _shared: EasyThemeManger = EasyThemeManger()
    private init (){}
    
    private lazy var once: () = {
        self.themeLoadConfig()
    }()
    
    public static func shared() -> EasyThemeManger {
        //加载配置信息
        _ = _shared.once
        // hook  didMoveToSuperview 方法
        UIView.initializeMethod()
        return _shared
    }
    
    ///配置主题数据，支持多个themeData，不同业务模块可以只维护自己的Color
    public static func configThemeData(themeData: EasyThemeDataProtocol) {
        guard _shared.themeDatas.contains(where: { (data: EasyThemeDataProtocol) -> Bool in
            return data as AnyObject === themeData as AnyObject
        }) == false else {
            return
        }
        _shared.themeDatas.append(themeData)
        _shared.themeData = themeData
    }
    
    
    ///获取图片
    public static func image(_ imageName: String) -> UIImage? {
        for themeData in EasyThemeManger._shared.themeDatas
            where
            themeData.easyThemeCanLoadImage(imageName, themeType: EasyThemeManger.shared().themeType) {
            return themeData.easyThemeImage(imageName, themeType: EasyThemeManger.shared().themeType)
        }
        return nil
    }
    
    ///获取颜色
    public static func color(_ colorName: String) -> UIColor? {
         for themeData in EasyThemeManger._shared.themeDatas
            where
            themeData.easyThemeCanLoadColor(colorName, themeType: EasyThemeManger.shared().themeType) {
            return themeData.easyThemeColor(colorName, themeType: EasyThemeManger.shared().themeType)
        }
        return nil
    }
    
    
    ///改变主题
    public static func changeTheme(theme: String?) {
        EasyThemeManger.saveThemeState(theme: theme)
        EasyThemeManger.shared().themeType = theme
        EasyThemeManger.shared().changeTableTheme()
    }
    
    ///将view放到weakTable中
    public static func addNoticeView(view: UIView?) {
        self.shared().weakTable.add(view)
    }
    
    ///更新界面UI
    private func changeTableTheme() {
        //切换到主线程
        DispatchQueue.main.async {
            let weakArray = self.weakTable.allObjects
            for view in weakArray {
                self.changeViewTheme(view)
            }
        }
    }
    
    private func changeViewTheme(_ view: UIView) {
        for subView in view.subviews {
            subView.checkThemeColor()
            subView.checkThemeImage()
            subView.checkThemeOther()
            changeViewTheme(subView)
        }
    }
}

///初始化Theme环境
extension EasyThemeManger {
    private func themeLoadConfig() {
        EasyThemeManger._shared.themeType = EasyThemeManger.loadThemeState()
    }
}

///同步本地数据
extension EasyThemeManger {
    private static let kThemeStateKey = "KEasyTheme_ThemeStateKey"
    private static func loadThemeState() -> String? {
        if let theme =  UserDefaults.standard.object(forKey:EasyThemeManger.kThemeStateKey) as? String {
            return theme
        }
        return nil
    }
    
    private static func saveThemeState(theme: String?) {
        UserDefaults.standard.set(theme, forKey: EasyThemeManger.kThemeStateKey)
        UserDefaults.standard.synchronize()
    }
    
}

///addTag
var KCOLORNAMEKEY: ()
extension UIColor {
    var colorName: String? {
        get {
            return objc_getAssociatedObject(self, &KCOLORNAMEKEY) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &KCOLORNAMEKEY, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}

var KIMAGENAMEKEY: ()
extension UIImage {
    var imageName: String? {
        get {
            return objc_getAssociatedObject(self, &KIMAGENAMEKEY) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &KIMAGENAMEKEY, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
}


