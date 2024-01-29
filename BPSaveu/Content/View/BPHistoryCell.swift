//
//  BPHistoryCell.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPHistoryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    var editHandle: ((BPModel)->Void)? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var model: BPModel = BPModel() {
        didSet{
            setupUI()
        }
    }
    
    func setupUI() {
        
        contentView.subviews.forEach({$0.removeFromSuperview()})
        
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(hex: 0x272C2E)
        shadowView.layer.shadowColor = UIColor(hex: 0xD7E5DD).cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 5
        shadowView.layer.cornerRadius = 12
        contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        let sysView = UIView()
        sysView.backgroundColor = .white
        contentView.addSubview(sysView)
        sysView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(shadowView)
        }
        
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor(hex: 0x272C2E).withAlphaComponent(0.5)
        timeLabel.font = .systemFont(ofSize: 11)
        timeLabel.text = model.time.formatter1
        sysView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        let sysLabel = LabelView(.sys, model: model)
        sysLabel.item = .sys
        sysLabel.model = model
        sysView.addSubview(sysLabel)
        sysLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.right.bottom.equalToSuperview()
        }
        
        let diaView = UIView()
        diaView.backgroundColor = .white
        contentView.addSubview(diaView)
        diaView.snp.makeConstraints { make in
            make.top.bottom.equalTo(shadowView)
            make.left.equalTo(sysView.snp.right).offset(1)
            make.width.equalTo(sysView.snp.width)
        }
        
        let sceneLabel = UILabel()
        sceneLabel.textColor = UIColor(hex: 0x272C2E).withAlphaComponent(0.5)
        sceneLabel.font = .systemFont(ofSize: 11)
        sceneLabel.text = model.scene.title
        diaView.addSubview(sceneLabel)
        sceneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        let diaLabel = LabelView(.dia, model: model)
        diaLabel.item = .dia
        diaLabel.model = model
        diaView.addSubview(diaLabel)
        diaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.right.bottom.equalToSuperview()
        }
        
        let pulView = UIView()
        pulView.backgroundColor = .white
        contentView.addSubview(pulView)
        pulView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(shadowView)
            make.left.equalTo(diaView.snp.right).offset(1)
            make.width.equalTo(sysView.snp.width)
        }
        
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "history_edit"), for: .normal)
        editButton.addTarget(self, action: #selector(editBAction), for: .touchUpInside)
        pulView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.centerX.equalToSuperview()
        }
        
        let pulLabel = LabelView(.pul, model: model)
        pulLabel.item = .pul
        pulLabel.model = model
        pulView.addSubview(pulLabel)
        pulLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    class LabelView: UIView {
        init(_ item: BPItem, model: BPModel){
            super.init(frame: .zero)
            self.item = item
            self.model = model
            setupUI()
        }
        
        var item: BPItem = .sys {
            didSet {
                setupUI()
            }
        }
        
        var model: BPModel = BPModel() {
            didSet {
                setupUI()
            }
        }
        
        private var gridentLayer = {
            let layer = CAGradientLayer()
            return layer
        }()
        
        func setupUI() {
            subviews.forEach({$0.removeFromSuperview()})
            
            let colorView = UIView()
            addSubview(colorView)
            colorView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(38)
            }
            
            gridentLayer.colors = [model.status.startColor.cgColor, model.status.endColor.cgColor]
            gridentLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gridentLayer.endPoint = CGPoint(x: 1, y: 0.5)
            colorView.layer.addSublayer(gridentLayer)
            
            let titleLabel = UILabel()
            titleLabel.text = item.capTitle
            titleLabel.textColor = .white
            titleLabel.font = .systemFont(ofSize: 16)
            colorView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            
            let valueLabel = UILabel()
            if item == .sys {
                valueLabel.text = "\(model.systolic)"
            } else if item == .dia {
                valueLabel.text = "\(model.diastolic)"
            } else if item == .pul {
                valueLabel.text = "\(model.pulse)"
            }
            valueLabel.textColor = UIColor(hex: 0x272C2E)
            valueLabel.font = .systemFont(ofSize: 32, weight: .semibold)
            addSubview(valueLabel)
            valueLabel.snp.makeConstraints { make in
                make.top.equalTo(colorView.snp.bottom).offset(6)
                make.centerX.equalToSuperview()
            }
            
            let unitLabel = UILabel()
            unitLabel.textColor = UIColor(hex: 0x272C2E).withAlphaComponent(0.3)
            unitLabel.text = "(\(item.unit))"
            unitLabel.font = .systemFont(ofSize: 11)
            addSubview(unitLabel)
            unitLabel.snp.makeConstraints { make in
                make.top.equalTo(valueLabel.snp.bottom).offset(4)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-12)
            }
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            gridentLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 38)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    @objc func editBAction() {
        editHandle?(model)
    }

}
