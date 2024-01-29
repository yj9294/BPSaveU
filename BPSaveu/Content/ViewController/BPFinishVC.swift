//
//  BPFinishVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class BPFinishVC: BaseVC {
    
    init(_ item: BPModel) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var item: BPModel = BPModel()
    
    private var item1: BPReadingItem = .protect
    private var item2: BPReadingItem = .protect
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));
        navigationItem.title = "Recording Finished"
    }
    
    @objc func back() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension BPFinishVC {
    
    override func setupUI() {
        super.setupUI()
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let topView = UIView()
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor(hex: 0xD7E5DD).cgColor
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.cornerRadius = 16
        topView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.leading.right.bottom.equalToSuperview()
        }
        
        let topBgView = UIImageView(image: UIImage(named: "finish_bg"))
        topBgView.contentMode = .scaleAspectFill
        topView.addSubview(topBgView)
        topBgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let sceneLabel = UILabel()
        sceneLabel.text = item.scene.title
        sceneLabel.textColor = UIColor(hex: 0x272C2E)
        sceneLabel.font = .systemFont(ofSize: 18)
        topView.addSubview(sceneLabel)
        sceneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(27)
        }
        
        let timeLabel = UILabel()
        timeLabel.text = item.time.formatter
        timeLabel.textColor = UIColor(hex: 0x272C2E).withAlphaComponent(0.87)
        topView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sceneLabel)
            make.left.equalTo(sceneLabel.snp.right).offset(11)
        }
        
        let sysLabel = BPFinishLabel(item.systolic, item: .sys)
        topView.addSubview(sysLabel)
        sysLabel.snp.makeConstraints { make in
            make.top.equalTo(sceneLabel.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(24)
        }
        
        let  diaLabel = BPFinishLabel(item.diastolic, item: .dia)
        topView.addSubview(diaLabel)
        diaLabel.snp.makeConstraints { make in
            make.top.equalTo(sysLabel)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let pulLabel = BPFinishLabel(item.pulse, item: .pul)
        topView.addSubview(pulLabel)
        pulLabel.snp.makeConstraints { make in
            make.top.equalTo(sysLabel)
            make.right.equalToSuperview().offset(-24)
        }
        
        let centerView = UIView()
        scrollView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let icon = UIImageView(image: UIImage(named: "bp_icon"))
        icon.contentMode = .scaleAspectFill
        centerView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(153)
            make.top.left.bottom.equalToSuperview()
        }
        
        let rightView = UIView()
        centerView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(17)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        let statusLabel = UILabel()
        statusLabel.text = item.status.title
        statusLabel.numberOfLines = 0
        statusLabel.textColor = item.status.endColor
        statusLabel.font = .systemFont(ofSize: 22, weight: .bold)
        rightView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        let statusRangeLabel = UILabel()
        statusRangeLabel.text = item.status.reason
        statusRangeLabel.textColor = UIColor(hex: 0x6B896E)
        statusRangeLabel.font = .systemFont(ofSize: 12)
        rightView.addSubview(statusRangeLabel)
        statusRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.left.equalTo(statusLabel)
        }
        
        let statusDescLabel = UILabel()
        statusDescLabel.text = item.status.description
        statusDescLabel.textColor = UIColor(hex: 0xAAC8AD)
        statusDescLabel.numberOfLines = 0
        statusDescLabel.font = .systemFont(ofSize: 12)
        rightView.addSubview(statusDescLabel)
        statusDescLabel.snp.makeConstraints { make in
            make.top.equalTo(statusRangeLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        
        let readingView = UIView()
        scrollView.addSubview(readingView)
        readingView.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        let readingTitle = UILabel()
        readingTitle.textColor = UIColor(hex: 0x272C2E)
        readingTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        readingTitle.text = "Recommended Reading"
        readingView.addSubview(readingTitle)
        readingTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        item1 = BPReadingItem.allCases[Int(arc4random()) % 4]
        let reading1 = BPReadingItemView(item1)
        reading1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoItem1)))
        readingView.addSubview(reading1)
        reading1.snp.makeConstraints { make in
            make.top.equalTo(readingTitle.snp.bottom).offset(20)
            make.height.equalTo(116)
            make.left.right.equalToSuperview()
        }
        
        item2 = BPReadingItem.allCases.filter({$0 != item1})[Int(arc4random()) % 3]
        let reading2 = BPReadingItemView(item2)
        reading2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoItem2)))
        readingView.addSubview(reading2)
        reading2.snp.makeConstraints { make in
            make.top.equalTo(reading1.snp.bottom).offset(16)
            make.height.equalTo(116)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension BPFinishVC {
    
    @objc func gotoItem1() {
        navigationController?.pushViewController(BPReadingDetailVC(item1), animated: true)
    }
    
    @objc func gotoItem2() {
        navigationController?.pushViewController(BPReadingDetailVC(item2), animated: true)
    }
}
