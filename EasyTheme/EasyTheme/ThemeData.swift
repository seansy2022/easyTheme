//
//  ThemeData.swift
//  EasyTheme
//
//  Created by sean on 2020/5/12.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit

struct ThemeData {
    struct type {
//        static let st
    }
}

extension ThemeData : EasyThemeDataProtocol {
    func easyThemeImage(_ keyName: String, themeType: String?) -> UIImage {
        return UIImage.init()
    }
    
    func easyThemeColor(_ keyName: String, themeType: String?) -> UIColor {
        return UIColor.init()
    }
    
    
}
