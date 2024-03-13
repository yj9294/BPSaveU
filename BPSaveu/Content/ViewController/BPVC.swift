//
//  BPVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class BPVC: BaseVC {
    
    init(_ item: BPModel, mode: BPControllerMode) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
        self.mode = mode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var mode: BPControllerMode = .new
    
    var item: BPModel = BPModel() {
        didSet {
            statusLabel.text = item.status.title
            statusRangeLabel.text = item.status.reason
            statusDescLabel.text = item.status.description
            sceneButton.title = item.scene.title
            timeButton.title = item.time.string
        }
    }
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var statusRangeLabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x6B896E)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var statusDescLabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0xAAC8AD)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var sceneButton = {
        let button = SelectButton(item.scene.title, item: .scene) {
            self.showSceneView()
        }
        return button
    }()
    
    lazy var timeButton = {
        let button = SelectButton(item.time.string, item: .time) {
            if self.mode == .new {
                self.showBPTimeView()
            }
        }
        return button
    }()
    
    lazy var sysView = {
        let view = SelectView(item.systolic, item: .sys) { sys in
            self.item.systolic = sys
        }
        return view
    }()
    
    lazy var diaView = {
        let view = SelectView(item.diastolic, item: .dia) { dia in
            self.item.diastolic = dia
        }
        return view
    }()
    
    lazy var pulView = {
        let view = SelectView(item.pulse, item: .pul) { pule in
            self.item.pulse = pule
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));
        navigationItem.title = mode == .new ? "Start Recording" : "Enter your bp"
        
        if mode == .edit {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bp_delete")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(deleteT))
        }
        
    }
    
    @objc func back() {
        GADUtil.share.show(.back) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func deleteT() {
        CacheUtil.shared.removeBPModel(item)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction() {
        if item.diastolic > item.systolic {
            TipView.Show("Confirm systolic is above diastolic.")
            return
        }
        
        if self.mode == .new {
            GADUtil.share.load(.submit)
            GADUtil.share.show(.submit) { _ in
                CacheUtil.shared.appBPModel(self.item)
                self.navigationController?.pushViewController(BPFinishVC(self.item), animated: true)
            }
        } else{
            CacheUtil.shared.updateBPModel(self.item)
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension BPVC {
    override func setupUI() {
        super.setupUI()
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let topView = UIView()
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(view.snp.width).offset(-40)
        }
        
        let icon = UIImageView(image: UIImage(named: "bp_icon"))
        icon.contentMode = .scaleAspectFill
        topView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(152)
        }
        
        let rightView = UIView()
        topView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(17)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        
        rightView.addSubview(statusLabel)
        statusLabel.text = item.status.title
        statusLabel.textColor = item.status.endColor
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        let infoButton = UIButton()
        infoButton.setImage(UIImage(named: "bp_info"), for: .normal)
        infoButton.addTarget(self, action: #selector(showBPStatusView), for: .touchUpInside)
        rightView.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(statusLabel).offset(-5)
            make.left.equalTo(statusLabel.snp.right).offset(4)
        }
        
        rightView.addSubview(statusRangeLabel)
        statusRangeLabel.text = item.status.reason
        statusRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.left.equalTo(statusLabel)
        }
        
        rightView.addSubview(statusDescLabel)
        statusDescLabel.text = item.status.description
        statusDescLabel.snp.makeConstraints { make in
            make.top.equalTo(statusRangeLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor(hex: 0xD7E5DD).cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.cornerRadius = 16
        contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        contentView.addSubview(sceneButton)
        sceneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        contentView.addSubview(timeButton)
        timeButton.snp.makeConstraints { make in
            make.top.equalTo(sceneButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        contentView.addSubview(sysView)
        sysView.snp.makeConstraints { make in
            make.top.equalTo(timeButton.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        contentView.addSubview(diaView)
        diaView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalTo(sysView)
        }
        contentView.addSubview(pulView)
        pulView.snp.makeConstraints { make in
            make.top.bottom.equalTo(sysView)
            make.right.equalToSuperview().offset(-22)
        }
        
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "guide_button"), for: .normal)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        scrollView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}

extension BPVC {
    
    @objc func showSceneView() {
        let view = BPSceneView(item.scene) { scene in
            self.item.scene = scene
        }
        let tabbar = tabBarController?.view
        tabbar?.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func showBPStatusView() {
        let view = BPStatusView()
        let tabbar = tabBarController?.view
        tabbar?.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func showBPTimeView() {
        let view = BPTimeView(item.time) { date in
            self.item.time = date
        }
        let tabbar = tabBarController?.view
        tabbar?.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
