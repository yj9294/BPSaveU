//
//  BPFinishLabel.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPFinishLabel: UIView {

    init(_ value: Int, item: BPItem) {
        super.init(frame: .zero)
        setupUI(value, item: item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var gradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hex: 0xF5FFF6).cgColor, UIColor(hex: 0xD1FFD5).cgColor]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return layer
    }()
    
    private var valueView = {
        let valueView = UIView()
        valueView.backgroundColor = .white
        valueView.layer.cornerRadius = 4
        valueView.layer.masksToBounds = true
        return valueView
    }()
    
    func setupUI(_ value: Int, item: BPItem) {
        let titleLabel = UILabel()
        titleLabel.text = item.capTitle
        titleLabel.textColor = UIColor(hex: 0x6B896E)
        titleLabel.font = .systemFont(ofSize: 16)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(valueView)
        valueView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.bottom.right.equalToSuperview()
        }
        
        valueView.layer.addSublayer(gradientLayer)
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        valueLabel.textColor = UIColor(hex: 0x272C2E)
        valueView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-35)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = valueView.bounds
    }
}
