//
//  GuideView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import Foundation
import GoogleMobileAds
import UIKit

class GuideView: UIView {
    init(completion: (()->Void)? = nil) {
        super.init(frame: .zero)
        setupUI()
        dismissHandle = completion
    }
    
    lazy var adView: GADNativeView = {
        let view = GADNativeView(.big)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nativeAD: GADNativeAd? = nil {
        didSet {
            adView.nativeAd = nativeAD
        }
    }
    
    private var dismissHandle: (()->Void)? = nil
    
    private func setupUI() {
        let bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.65)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let icon = UIImageView(image: UIImage(named: "guide_icon"))
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(150)
        }
        
        let button = UIButton()
        button.setTitle("Add Record", for: .normal)
        button.setImage(UIImage(named: "guide_add"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -28, bottom: 0, right: 0)
        button.setBackgroundImage(UIImage(named: "guide_button"), for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(38)
        }
        
        addSubview(adView)
        adView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(174)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
    }
    
    @objc func dismiss() {
        self.removeFromSuperview()
        dismissHandle?()
    }
}
