//
//  BaseVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addGiadientLayer()
        setupUI()
    }

    deinit {
        debugPrint("\(self) deini! 🫠🫠🫠")
    }

}

extension BaseVC {
    @objc func setupUI() {
    }
    
    func addGiadientLayer() {
        view.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor(hex: 0xFCFDFD).cgColor, UIColor(hex: 0xE8F9EF).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.addSublayer(gradientLayer)
    }
}
