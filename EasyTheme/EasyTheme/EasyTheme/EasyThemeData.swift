//
//  EasyThemeLoad.swift
//  beater
//
//  Created by sean on 2020/4/29.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
public protocol EasyThemeDataProtocol {
    func loadImage(_ keyName: String, themeType: String) -> UIImage?
    
    func loadColor(_ keyName: String, themeType: String) -> UIColor?
}
