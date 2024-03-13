//
//  HomeVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class HomeVC: CusTabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let _ = viewController as? VisionsVC {
            GADUtil.share.load(.back)
        }
        return true
    }
}
