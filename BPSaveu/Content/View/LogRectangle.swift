//
//  LogRectangle.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation
import UIKit


class Rectangle: UIView {
    var text: String = "" {
        didSet {
            titleLabel.text = text
        }
    }
    
    private var item: BPItem = .sys
    
    private lazy var titleLabel = {
        let titleLabe = UILabel()
        titleLabe.text = text
        titleLabe.textColor = UIColor(hex: 0x272C2E)
        titleLabe.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return titleLabe
    }()
    private lazy var gradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: 0xF5FFF6).cgColor, UIColor(hex: 0xD1FFD5).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer;
    }()
    
    init(_ text: String, item: BPItem) {
        super.init(frame: .zero)
        self.text = text
        self.item = item
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        layer.addSublayer(gradientLayer)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
        }
        
        let unitLabel = UILabel()
        unitLabel.textColor = UIColor(hex: 0x92CC98)
        unitLabel.font = .systemFont(ofSize: 11)
        unitLabel.text = "(\(item.unit)"
        addSubview(unitLabel)
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-7)
        }
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
