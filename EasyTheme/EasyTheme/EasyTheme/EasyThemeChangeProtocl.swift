//
//  EasyThemeProtocl.swift
//
//
//  Created by sean on 2020/5/12.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
protocol EasyThemeChangeProtocl {
    func checkThemeColor()
    func checkThemeImage()
    ///可以扩展其他
    func checkThemeOther()
}

///实现了 backgroundColor
extension UIView : EasyThemeChangeProtocl {
    @objc func checkThemeColor() {
        guard let colorName = self.backgroundColor?.colorName else {
            return
        }
        
        self.backgroundColor = UIColor.ThemeColor(colorName)
    }
    
    @objc func checkThemeImage() {
    }
    
    @objc func checkThemeOther() {
    }
}

///实现了 textColor
extension UILabel {
    override func checkThemeColor() {
        super.checkThemeColor()
        guard let titleColorName = self.textColor?.colorName else {
            return
        }
        self.textColor = UIColor.ThemeColor(titleColorName)
    }
}

///实现了 image
extension UIImageView {
    override func checkThemeImage() {
        super.checkThemeImage()
        guard let imageName = self.image?.imageName else {
            return
        }
        self.image = UIImage.ThemeImage(imageName)
    }
}

///实现了 image/titleColor/titleShadowColor/backgroundImage
extension UIButton {
    var controlState : [UIControl.State] {
        return [.normal, .disabled, .selected, .focused, .application, .reserved]
    }
    
    override func checkThemeImage() {
        super.checkThemeImage()
        themeImage()
        themeBackgroundImage()
    }
    
    override func checkThemeColor() {
        super.checkThemeColor()
        themeTitleColor()
        themeTitleShadowColor()
    }
    
    private func themeImage() {
        for state in controlState {
            guard let imageName = self.image(for: state)?.imageName else {
                return
            }
            self.setImage(UIImage.ThemeImage(imageName), for: state)
        }
    }
    
    private func themeTitleColor() {
        for state in controlState {
            guard let titleName = self.titleColor(for: state)?.colorName else {
                return
            }
            self.setTitleColor(UIColor.ThemeColor(titleName), for: state)
        }
    }
    
    
    private func themeTitleShadowColor() {
        for state in controlState {
            guard let titleName = self.titleShadowColor(for: state)?.colorName else {
                return
            }
            self.setTitleShadowColor(UIColor.ThemeColor(titleName), for: state)
        }
    }
    
    private func themeBackgroundImage() {
        for state in controlState {
            guard let imageName = self.backgroundImage(for: state)?.imageName else {
                return
            }
            self.setBackgroundImage(UIImage.ThemeImage(imageName), for: state)
        }
    }
    
}

///实现了 background/disabledBackground/textColor
extension UITextField {
    override func checkThemeImage() {
        super.checkThemeImage()
        themeBackgroundImage()
        themeDisabledBackground()
    }
    
    override func checkThemeColor() {
        super.checkThemeColor()
        themeTextColor()
    }
    
    private func themeBackgroundImage() {
        guard let backgroundName = self.background?.imageName else {
            return
        }
        self.background = UIImage.ThemeImage(backgroundName)
    }
    
    private func themeDisabledBackground() {
        guard let disabledBackground = self.disabledBackground?.imageName else {
            return
        }
        self.disabledBackground = UIImage.ThemeImage(disabledBackground)
    }
    
    private func themeTextColor() {
        guard let textColorName = self.textColor?.colorName else {
            return
        }
        self.textColor = UIColor.ThemeColor(textColorName)
    }
}

///实现了 textColor
extension UITextView {
    override func checkThemeColor() {
        super.checkThemeColor()
        guard let textColorName = self.textColor?.colorName else {
            return
        }
        self.textColor = UIColor.ThemeColor(textColorName)
    }
}


extension UIColor {
    static func ThemeColor(_ name: String) -> UIColor? {
        guard  let color = EasyThemeManger.color(name) else {
            return nil
        }
        color.colorName = name
        return color
    }
}

extension UIImage {
    static func ThemeImage(_ name: String) -> UIImage? {
        guard let image = EasyThemeManger.image(name) else {
            return nil
        }
        image.imageName = name
        return image
    }
}
