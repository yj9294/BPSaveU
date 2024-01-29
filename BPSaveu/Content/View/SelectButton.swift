//
//  SelectButton.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class SelectButton: UIView {
    
    enum ButtonType: String {
        case scene, time
    }
    
    init(_ title: String, item: ButtonType, onTap: (()->Void)? = nil) {
        super.init(frame: .zero)
        self.title = title
        self.item = item
        self.onTapHandle = onTap
        setupUI()
    }
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var item: ButtonType = .scene
    private var onTapHandle: (()->Void)? = nil
    
    private var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hex: 0x6B896E)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: 0xF4F7F5)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        let centerView = UIView()
        addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let icon = UIImageView(image: UIImage(named: "bp_\(item.rawValue)_edit"))
        centerView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        
        centerView.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(7)
        }
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func buttonAction() {
        onTapHandle?()
    }

}
