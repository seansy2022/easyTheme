//
//  EasyThemeLoad.swift
//  beater
//
//  Created by sean on 2020/4/29.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
public protocol EasyThemeDataProtocol {
    func easyThemeCanLoadImage(_ keyName: String, themeType: String?) -> Bool
    func easyThemeImage(_ keyName: String, themeType: String?) -> UIImage
    
    func easyThemeCanLoadColor(_ keyName: String, themeType: String?) -> Bool
    func easyThemeColor(_ keyName: String, themeType: String?) -> UIColor
}

extension EasyThemeDataProtocol {
    func easyThemeCanLoadImage(_ keyName: String, themeType: String?) -> Bool {
        return true
    }
    
    func easyThemeCanLoadColor(_ keyName: String, themeType: String?) -> Bool {
        return true
    }
}
