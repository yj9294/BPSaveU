//
//  CusTabBar.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.width = UIScreen.main.bounds.width - 48  // 设置宽度为屏幕宽度减去一定的边距
        return sizeThatFits
    }
}
