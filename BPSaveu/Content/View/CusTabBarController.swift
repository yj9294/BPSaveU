//
//  CusTabBarController.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation
import UIKit

class CusTabBarController: UITabBarController {
    //底部高度
    var bottomHeight:Int?
    //判断机型
    var iPhoneX = UIScreen.main.bounds.size.height >= 812 ? true : false
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(), forKey: "tabBar")
        self.tabBar.tintColor = UIColor(hex: 0x13BF7C)
        addChildViewControllers()
    }
    //改变tabbar的位置和高度
    override func viewDidLayoutSubviews() {
        if iPhoneX {
            bottomHeight = 34
        }else{
            bottomHeight = 21
        }
        setupTabbar()
    }
    
    func setupTabbar() {
        var frame = self.tabBar.frame
        frame.size.height = 64
        frame.size.width = UIScreen.main.bounds.width - 48
        frame.origin.x = 24
        frame.origin.y = self.view.frame.size.height - frame.size.height - CGFloat(bottomHeight!)
        self.tabBar.frame = frame
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.cornerRadius = 24
        self.tabBar.layer.masksToBounds = true
    }
        
    private func addChildViewControllers() {
        setChildViewController(LogVC(), title: "Log", imageName: "home_log", selectedImageName: "home_log_1")
        setChildViewController(VisionsVC(), title: "Visions", imageName: "home_visions", selectedImageName: "home_visions_1")
        setChildViewController(SettingsVC(), title: "Settings", imageName: "home_settings", selectedImageName: "home_settings_1")
    }
    
    private func setChildViewController(_ childController:UIViewController, title:String, imageName:String, selectedImageName:String){
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -8)
        let nav = UINavigationController(rootViewController: childController)
        self.addChild(nav)
    }
}
