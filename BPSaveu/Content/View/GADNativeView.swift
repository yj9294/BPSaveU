//
//  GADNativeView.swift
//  BPSaveu
//
//  Created by Super on 2024/3/6.
//

import Foundation
import UIKit
import GoogleMobileAds

class GADNativeView: GADNativeAdView {
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: 0x333333)
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hex: 0x808080)
        label.font = .systemFont(ofSize: 11.0)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 4
        icon.layer.masksToBounds = true
        icon.backgroundColor = UIColor.init(hex: 0xD8D8D8)
        return icon
    }()
    
    lazy var bigImage: GADMediaView = {
        let view = GADMediaView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.init(hex: 0xD8D8D8)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var adTag: UIImageView = {
        let image = UIImageView(image: UIImage(named: "ad_tag"))
        return image
    }()
    
    lazy var install: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.init(hex: 0x2394E4)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    enum Style {
        case small, big
    }
    
    init(_ style: Style) {
        super.init(frame: .zero)
        setupUI(style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(_ style: Style) {
        if style == .big {
            self.backgroundColor = .white
            self.layer.cornerRadius = 10
            self.layer.masksToBounds = true
            
            addSubview(bigImage)
            bigImage.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(13)
                make.left.equalToSuperview().offset(10)
                make.height.equalTo(100)
                make.right.equalToSuperview().offset(-118)
            }
            
            adTag.image = UIImage(named: "ad_tag")
            addSubview(adTag)
            adTag.snp.makeConstraints { make in
                make.top.equalTo(bigImage)
                make.left.equalTo(bigImage)
            }
            
            addSubview(icon)
            icon.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(13)
                make.left.equalTo(bigImage.snp.right).offset(10)
                make.width.height.equalTo(40)
            }
            
            addSubview(title)
            title.snp.makeConstraints { make in
                make.top.equalTo(icon.snp.bottom).offset(11)
                make.left.equalTo(icon)
                make.right.equalToSuperview().offset(-10)
            }
            
            subTitle.numberOfLines = 2
            addSubview(subTitle)
            subTitle.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.equalTo(title)
                make.right.equalTo(title)
            }
            
            addSubview(install)
            install.snp.makeConstraints { make in
                make.top.equalTo(bigImage.snp.bottom).offset(12)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.height.equalTo(36)
            }
            
        } else {
            self.backgroundColor = .white
            self.layer.cornerRadius = 8
            self.layer.masksToBounds = true
            
            addSubview(icon)
            icon.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.left.equalToSuperview().offset(14)
                make.width.height.equalTo(44)
            }
            
            addSubview(title)
            title.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(19)
                make.left.equalTo(icon.snp.right).offset(8)
                make.right.equalToSuperview().offset(136)
            }
            
            adTag.image = UIImage(named: "ad_tag_1")
            addSubview(adTag)
            adTag.snp.makeConstraints { make in
                make.centerY.equalTo(title)
                make.left.equalTo(title.snp.right).offset(6)
            }
            
            addSubview(install)
            install.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-14)
                make.width.equalTo(72)
                make.height.equalTo(40)
            }
            
            subTitle.numberOfLines = 1
            addSubview(subTitle)
            subTitle.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom).offset(9)
                make.left.equalTo(title)
                make.right.equalToSuperview().offset(-90)
            }
        }
    }
    
    override var nativeAd: GADNativeAd? {
        didSet{
            refreshUI(with: nativeAd)
        }
    }
    
    func refreshUI(with ad: GADNativeAd?) {
        guard let ad = ad else {
            self.isHidden = true
            return
        }
        self.isHidden = false
        icon.image = ad.icon?.image
        title.text = ad.headline
        subTitle.text = ad.body
        install.setTitle(ad.callToAction, for: .normal)
        bigImage.mediaContent = ad.mediaContent
        
        iconView = icon
        mediaView = bigImage
        callToActionView = install
        headlineView = title
        bodyView = subTitle
        advertiserView = adTag
    }
}
