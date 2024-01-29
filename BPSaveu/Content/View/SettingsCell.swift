//
//  SettingsCell.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class SettingsCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: SettingItem = .privacy {
        didSet {
            setupUI()
        }
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
        
        contentView.subviews.forEach({$0.removeFromSuperview()})
        let icon = UIImageView(image: UIImage(named: item.icon))
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        let title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .medium)
        title.textColor = UIColor(hex: 0x131A17)
        title.text = item.title
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(12)
        }
        
        let arrow = UIImageView(image: UIImage(named: "arrow"))
        contentView.addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

}
