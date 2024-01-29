//
//  BPTimeView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class BPTimeView: UIView {

    init(_ date: Date, completion: ((Date)->Void)? = nil) {
        super.init(frame: .zero)
        self.date = date
        self.okHandle = completion
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var date: Date = Date()
    private var okHandle: ((Date)->Void)? = nil
    private var datePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    func setupUI() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissAction)))
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let contentView = UIView()
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 24
        contentView.backgroundColor = .white
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Reference standard"
        titleLabel.textColor = UIColor(hex: 0x1D1D3A)
        titleLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(datePicker)
        datePicker.date = date
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(216)
        }
        
        let button = UIButton()
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "guide_button"), for: .normal)
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(datePicker.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }

    }
    
    @objc func dismissAction() {
        self.removeFromSuperview()
    }
    
    @objc func okAction() {
        self.removeFromSuperview()
        okHandle?(datePicker.date)
    }

}
