//
//  TipView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class TipView: UIView {
    
    static func Show(_ message: String, completion: (()->Void)? = nil) {
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let window = scene.windows.filter({$0.isKeyWindow}).first {
            window.subviews.filter({$0 is TipView}).forEach({$0.removeFromSuperview()})
            let view = TipView(message)
            window.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.removeFromSuperview()
                completion?()
            }
        }
    }
    
    init(_ message: String) {
        super.init(frame: .zero)
        setupUI(message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(_ message: String){
        let contentView = UIView()
        contentView.backgroundColor = UIColor(hex: 0x388A48).withAlphaComponent(0.72)
        contentView.layer.cornerRadius = 12
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        let title = UILabel()
        title.textColor = .white
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 16)
        title.numberOfLines = 0
        title.text = message
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-28)
        }
    }
    
}
