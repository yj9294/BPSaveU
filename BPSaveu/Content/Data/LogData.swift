//
//  log_model.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation

// 筛选方式
enum LogMode: Codable, CaseIterable {
    // 赋用户最近一次记录的三个数值；
    // 三个数值分别赋用户全部记录的对应数值的平均值；
    // 三个数值分别赋用户48小时内全部记录的对应数值的平均值；
    case newest, average, twodays
    
    var title: String {
        switch self {
        case .newest:
            return "Newest Record"
        case .average:
            return "Average Record"
        case .twodays:
            return "48 Hour Average "
        }
    }
}

// 血压
enum BPItem {
    case sys, dia, pul
    var title: String {
        switch self {
        case .sys:
            return "Systolic"
        case .dia:
            return "Diastolic"
        case .pul:
            return "Pulse"
        }
    }
    
    var capTitle: String {
        switch self {
        case .sys:
            return "SYS"
        case .dia:
            return "DIA"
        case .pul:
            return "PULSE"
        }
    }
    
    var unit: String {
        switch self {
        case .sys, .dia:
            return "mmhg"
        case .pul:
            return "BPM"
        }
    }
}
