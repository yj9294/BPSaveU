//
//  LoadingVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class LoadingVC: BaseVC {
    
    var timer: Timer? = nil
    var progress: Double = 0.0 {
        didSet {
            progressView.progress = Float(progress)
        }
    }
    let duration = 3.0
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor = UIColor(hex: 0x4FCD69)
        progressView.tintColor = UIColor(hex: 0x398D4D)
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension LoadingVC {
    override func setupUI() {
        super.setupUI()
        let imageView = UIImageView(image: UIImage(named: "loading_bg"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-70)
            make.height.equalTo(4)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        let title = UIImageView(image: UIImage(named: "loading_title"))
        title.contentMode = .scaleAspectFill
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(116)
            make.height.equalTo(26)
            make.bottom.equalTo(progressView.snp.top).offset(-67)
        }
        
        let icon = UIImageView(image: UIImage(named: "loading_icon"))
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(title.snp.top).offset(-24)
            make.height.width.equalTo(108)
        }
    }
    
    func startLoading() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(loading), userInfo: nil, repeats: true)
    }
    
    @objc func loading() {
        progress += 0.01 / duration
        if progress >= 1.0 {
            progress = 1.0
            timer?.invalidate()
            NotificationCenter.default.post(name: .applicationHome, object: nil)
        }
    }
    
}
