//
//  AppUtil.swift
//  BPSaveu
//
//  Created by Super on 2024/3/6.
//

import Foundation
import UIKit

class AppUtil {
    static var rootVC: UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let window = scene.windows.filter({$0.isKeyWindow}).first  {
            return window.rootViewController
        }
        return nil
    }
}
