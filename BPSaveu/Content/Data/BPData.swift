//
//  BPData.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

enum BPControllerMode {
    case new, edit
}

enum BPStatus: String,  Codable, CaseIterable {
    case hyp, normal, elevated, hy1, hy2, hyp3
    var title: String {
        switch self {
        case .hyp:
            return "Hypotension"
        case .normal:
            return "Normal"
        case .elevated:
            return "Elevated"
        case .hy1:
            return "Hypertension·Stage 1"
        case .hy2:
            return "Hypertension·Stage 2"
        case .hyp3:
            return "Hypertension·Stage 3"
        }
    }
    
    var reason: String {
        switch self {
        case .hyp:
            return "SYS: 30～89, or DIA 30～59"
        case .normal:
            return "SYS: 90～119, and DIA 60～79"
        case .elevated:
            return "SYS: 120～129, and DIA 60～79"
        case .hy1:
            return "SYS: 130～139, or DIA 80～89"
        case .hy2:
            return "SYS: 140～180, or DIA 90～120"
        case .hyp3:
            return "SYS: 181～300, or DIA 121～300"
        }
    }
    
    var description: String {
        switch self {
        case .hyp:
            return "For those facing low blood pressure, consulting a healthcare professional is a prudent step."
        case .normal:
            return "Stay dedicated to your well-balanced and healthy living habits."
        case .elevated:
            return "Lower your risk by adopting healthier habits into your daily life."
        case .hy1:
            return "Anticipate and manage elevated BP by considering lifestyle adjustments for a healthier life."
        case .hy2:
            return "For additional advice, it is advisable to consult with a healthcare expert."
        case .hyp3:
            return "Seeking immediate medical care is strongly advised. Your health is our topmost concern."
        }
    }
    
    var gridentLayer: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer
    }
    
    var startColor: UIColor {
        switch self {
        case .hyp:
            return UIColor(hex: 0x6FADF5)
        case .normal:
            return UIColor(hex: 0x67F17D)
        case .elevated:
            return UIColor(hex: 0xD4F012)
        case .hy1:
            return UIColor(hex: 0xFFE300)
        case .hy2:
            return UIColor(hex: 0xFF9552)
        case .hyp3:
            return UIColor(hex: 0xFF504E)
        }
    }
    
    var endColor: UIColor {
        switch self {
        case .hyp:
            return UIColor(hex: 0x3C75E8)
        case .normal:
            return UIColor(hex: 0x12CF22)
        case .elevated:
            return UIColor(hex: 0xC2DB12)
        case .hy1:
            return UIColor(hex: 0xFFC300)
        case .hy2:
            return UIColor(hex: 0xFF541C)
        case .hyp3:
            return UIColor(hex: 0xFF1615)
        }
    }
}

enum BPScene: CaseIterable, Codable {
    case night, meal, seated, workout, standard, rest
    var title: String {
        switch self {
        case .night:
            return "Nighttime"
        case .meal:
            return "Post-Meal"
        case .seated:
            return "Seated"
        case .workout:
            return "Post-Workout"
        case .standard:
            return "Standard"
        case .rest:
            return "Rest"
        }
    }
    init(_ item: String?) {
        switch item {
        case BPScene.night.title:
            self = .night
        case BPScene.meal.title:
            self = .meal
        case BPScene.seated.title:
            self = .seated
        case BPScene.workout.title:
            self = .workout
        case BPScene.standard.title:
            self = .standard
        case BPScene.rest.title:
            self = .rest
        default:
            self = .night
        }
    }
}

struct BPModel: Codable, Equatable {
    var systolic: Int = 103 // 收缩呀
    var diastolic: Int = 72  // 舒张压
    var pulse: Int = 67 // 心率
    var scene: BPScene = .standard
    var time: Date = Date()
    
    var status: BPStatus {
        if systolic < 90 || diastolic < 60 {
            return .hyp
        }
        if 90..<120 ~= systolic, 60..<80 ~= diastolic {
            return .normal
        }
        if 120..<130 ~= systolic,  60..<80 ~= diastolic {
            return .elevated
        }
        
        if 130..<140 ~= systolic || 80..<90 ~= diastolic {
            return .hy1
        }
        if 140...180 ~= systolic || 90...120 ~= diastolic {
            return .hy2
        }
        if systolic > 180 || diastolic > 120 {
            return .hyp3
        }
        return .normal
    }
}
