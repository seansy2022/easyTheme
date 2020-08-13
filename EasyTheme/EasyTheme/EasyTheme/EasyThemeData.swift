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


class EasyThemeData: EasyThemeDataProtocol {
    func easyThemeImage(_ keyName: String, themeType: String?) -> UIImage {
      
           if(themeType == "1") {
            let a =   UIImage.init(named: "main_tabbar_bg_dark")
                          return a  ?? UIImage.init()
        
            
        }
              let a =   UIImage.init(named: "Subtract")
          //              a.imageName = "1"
                      return a ?? UIImage.init()
    }
    
    func easyThemeColor(_ keyName: String, themeType: String?) -> UIColor {
              if(themeType == "1") {
              let a = UIColor.red
//                a.colorName = "1"
                return a;
          }
            let a = UIColor.green
                      a.colorName = "1"
                      return a;
    }
    
    
}
