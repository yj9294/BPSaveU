//
//  BPStatusCell.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class BPStatusCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: BPStatus = .hyp {
        didSet {
            setupUI()
        }
    }
    
    private lazy var gradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.item.startColor.cgColor, self.item.endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = item.title
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var contentLabel = {
        let label = UILabel()
        label.text = item.reason
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    func setupUI() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.subviews.forEach { v in
            v.removeFromSuperview()
        }
        gradientLayer.removeFromSuperlayer()
        contentView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(titleLabel)
        titleLabel.text = item.title
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.text = item.reason
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
