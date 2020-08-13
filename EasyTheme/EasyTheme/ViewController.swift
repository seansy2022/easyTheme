//
//  ViewController.swift
//  EasyTheme
//
//  Created by sean on 2020/5/12.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myView :UIView = UIView.init(frame: CGRect.init(x:100, y: 10, width: 110, height: 200))
    var a : Bool  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "as"
        self.navigationController?.navigationBar.barTintColor = UIColor.ThemeColor("1")
        self.view.addSubview(myView)
        myView.backgroundColor = UIColor.ThemeColor("1")
        myView.tag = 1;
        

        self.navigationController?.navigationBar.tintColor = UIColor.ThemeColor("1")
        self.navigationController?.navigationBar.tag = 2
        if let a =  (UIApplication.shared.windows.first?.rootViewController ) as? UITabBarController  {
                a.tabBar.tintColor = UIColor.ThemeColor("1")
            let image = UIImage.ThemeImage("1")
            a.tabBar.backgroundImage = image
            
            
        }

   
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if a {
             EasyThemeManger.changeTheme(theme: "1")
           
        }else{
             EasyThemeManger.changeTheme(theme: "0")
        }
         a = !a
    }

}

