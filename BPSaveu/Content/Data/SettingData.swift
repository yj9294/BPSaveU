//
//  SettingData.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

enum SettingItem: String, CaseIterable {
    case feedback, privacy
    
    var title: String {
        switch self {
        case .privacy:
            return "Privacy Policy"
        case .feedback:
            return "Feedback"
        }
    }
    
    var icon: String {
        return "setting_\(self.rawValue)"
    }
}
