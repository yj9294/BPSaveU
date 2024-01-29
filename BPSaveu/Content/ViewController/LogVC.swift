//
//  LogVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit
import AppTrackingTransparency

class LogVC: BaseVC {
    
    lazy var modeTitle: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hex: 0x272C2E)
        label.font = .systemFont(ofSize: 18)
        label.text = CacheUtil.shared.logMode.title
        return label
    }()
    
    lazy var sysLabel: Rectangle = {
        let label = Rectangle("100", item: .sys)
        return label
    }()
    
    lazy var diaLabel: Rectangle = {
        let label = Rectangle("100", item: .dia)
        return label
    }()
    
    lazy var pulLabel: Rectangle = {
        let label = Rectangle("100", item: .pul)
        return label
    }()
    
    var item: LogMode = CacheUtil.shared.logMode {
        didSet {
            modeTitle.text = item.title
            CacheUtil.shared.logMode = item
        }
    }
    
    var model: BPModel {
        switch item {
        case .newest:
            return CacheUtil.shared.getBPModels().first ?? BPModel(systolic: 0, diastolic: 0, pulse: 0)
        case .average:
            let models = CacheUtil.shared.getBPModels()
            if models.isEmpty {
                return BPModel(systolic: 0, diastolic: 0, pulse: 0)
            }
            let sys = models.map({$0.systolic}).reduce(0, +) / models.count
            let dia = models.map({$0.diastolic}).reduce(0, +) / models.count
            let pul = models.map({$0.pulse}).reduce(0, +) / models.count
            return BPModel(systolic: sys, diastolic: dia, pulse: pul)
        case .twodays:
            let models = CacheUtil.shared.getBPModels().filter({$0.time.isInTwoDays})
            if models.isEmpty {
                return BPModel(systolic: 0, diastolic: 0, pulse: 0)
            }
            let sys = models.map({$0.systolic}).reduce(0, +) / models.count
            let dia = models.map({$0.diastolic}).reduce(0, +) / models.count
            let pul = models.map({$0.pulse}).reduce(0, +) / models.count
            return BPModel(systolic: sys, diastolic: dia, pulse: pul)
        }
    }
    
    var isGuide: Bool {
        return CacheUtil.shared.getBPModels().count == 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupModeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupModeView()
        if isGuide {
            sysLabel.text = "103"
            diaLabel.text = "72"
            pulLabel.text = "67"
            item = .newest
            showGuideView()
        }
        ATTrackingManager.requestTrackingAuthorization { _ in
        }
    }

}

extension LogVC {
    override func setupUI() {
        super.setupUI()
        navigationItem.titleView = UIImageView(image: UIImage(named: "log_title"))
        
        let contentView = UIView()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let contentBackgroundView = UIImageView(image: UIImage(named: "log_bg"))
        contentBackgroundView.contentMode = .scaleAspectFill
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let buttonView = UIView()
        contentView.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
        }
        
        let leftButton = UIButton()
        leftButton.addTarget(self, action: #selector(lastMode), for: .touchUpInside)
        leftButton.setImage(UIImage(named: "log_left"), for: .normal)
        buttonView.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        buttonView.addSubview(modeTitle)
        modeTitle.snp.makeConstraints { make in
            make.left.equalTo(leftButton.snp.right).offset(13)
            make.centerX.centerY.equalToSuperview()
        }
        
        let rightButton = UIButton()
        rightButton.addTarget(self, action: #selector(nextMode), for: .touchUpInside)
        rightButton.setImage(UIImage(named: "log_right"), for: .normal)
        buttonView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
            make.left.equalTo(modeTitle.snp.right).offset(13)
            make.width.height.equalTo(20)
        }
        
        contentView.addSubview(sysLabel)
        sysLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(23)
            make.top.equalTo(buttonView.snp.bottom).offset(22)
            make.width.equalTo(116)
            make.height.equalTo(64)
        }
        
        contentView.addSubview(diaLabel)
        diaLabel.snp.makeConstraints { make in
            make.left.equalTo(sysLabel)
            make.top.equalTo(sysLabel.snp.bottom).offset(20)
            make.width.equalTo(116)
            make.height.equalTo(64)
        }
        
        contentView.addSubview(pulLabel)
        pulLabel.snp.makeConstraints { make in
            make.left.equalTo(sysLabel)
            make.top.equalTo(diaLabel.snp.bottom).offset(20)
            make.width.equalTo(116)
            make.height.equalTo(64)
        }
        
        let historyButton = UIButton()
        historyButton.setBackgroundImage(UIImage(named: "log_history"), for: .normal)
        historyButton.setTitleColor(UIColor(hex: 0x13BF7C), for: .normal)
        historyButton.addTarget(self, action: #selector(goHistoryVC), for: .touchUpInside)
        historyButton.setTitle("History", for: .normal)
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        let bpButton = UIButton()
        bpButton.setBackgroundImage(UIImage(named: "log_bp"), for: .normal)
        bpButton.setTitleColor(UIColor.white, for: .normal)
        bpButton.setTitle("Log BP", for: .normal)
        bpButton.addTarget(self, action: #selector(goBPVC), for: .touchUpInside)
        view.addSubview(bpButton)
        bpButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(20)
            make.left.equalTo(historyButton.snp.right).offset(14)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(historyButton.snp.width)
        }
    }
    
    func showGuideView() {
        let view = GuideView{
            self.setupModeView()
            // 跳转新增BP
            self.goBPVC()
        }
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let window = scene.windows.filter({$0.isKeyWindow}).first  {
            window.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
        }
    }
    
    func setupModeView() {
        self.sysLabel.text = "\(self.model.systolic)"
        self.diaLabel.text = "\(self.model.diastolic)"
        self.pulLabel.text = "\(self.model.pulse)"
    }
}

extension LogVC {
    @objc func nextMode() {
        let index = LogMode.allCases.firstIndex(of: item) ?? 0
        item = LogMode.allCases[(index + 1) % LogMode.allCases.count]
        setupModeView()
    }
    
    @objc func lastMode() {
        let index = (LogMode.allCases.firstIndex(of: item) ?? 0) + 3
        item = LogMode.allCases[(index - 1) % LogMode.allCases.count]
        setupModeView()
    }
    
    @objc func goBPVC() {
        let vc = BPVC(BPModel(), mode: .new)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goHistoryVC() {
        let vc = BPHistoryVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
