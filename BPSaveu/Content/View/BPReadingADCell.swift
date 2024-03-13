//
//  BPReadingADCell.swift
//  BPSaveu
//
//  Created by Super on 2024/3/6.
//

import UIKit
import GoogleMobileAds

class BPReadingADCell: UITableViewCell {
    
    lazy var adView: GADNativeView = {
        let view = GADNativeView(.big)
        return view
    }()
    
    var ad: GADNativeAd? {
        didSet{
            adView.nativeAd = ad
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
        
        addSubview(adView)
        adView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(174)
            make.bottom.equalToSuperview().offset(0)
        }
    }

}
