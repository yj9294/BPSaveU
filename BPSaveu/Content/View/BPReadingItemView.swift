//
//  BPReadingItemView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPReadingItemView: UIView {
    
    init(_ item: BPReadingItem) {
        super.init(frame: .zero)
        setupUI(item)
    }
    
    var item: BPReadingItem = .protect {
        didSet {
            setupUI(item)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(_ item: BPReadingItem) {
        subviews.forEach({$0.removeFromSuperview()})
        
        let bgView = UIImageView(image: UIImage(named: item.bgIcon))
        bgView.contentMode = .scaleAspectFill
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let icon = UIImageView(image: UIImage(named: item.icon))
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(116)
        }
        
        let title = UILabel()
        title.textColor = UIColor(hex: 0x30313C)
        title.font = .systemFont(ofSize: 14)
        title.numberOfLines = 0
        title.text = item.title
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(icon.snp.right)
        }
    }
}

class BPReadingItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = .clear
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var item: BPReadingItem = .protect {
        didSet {
            itemView.item = item
        }
    }
    
    private var itemView: BPReadingItemView = {
        let view = BPReadingItemView(.protect)
        return view
    }()
    
    private func setupUI() {
        contentView.addSubview(itemView)
        itemView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
