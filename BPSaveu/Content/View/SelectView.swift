//
//  SelectView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class SelectView: UIView {
    init(_ value: Int, item: BPItem, selected:((Int)->Void)? = nil) {
        super.init(frame: .zero)
        self.value = value
        self.item = item
        self.didSelected = selected
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let titleView = UIView()
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.text = item.title
        titleLabel.textColor = UIColor(hex: 0x6B896E)
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        let unitLabel = UILabel()
        unitLabel.text = "(\(item.unit))"
        unitLabel.font = .systemFont(ofSize: 12, weight: .regular)
        unitLabel.textColor = UIColor(hex: 0xAAC8AD)
        titleView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        let pickerView = UIView()
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        let bgView = UIImageView(image: UIImage(named: "bp_scroll"))
        pickerView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        pickerView.addSubview(picker)
        picker.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(76)
            make.height.equalTo(193)
        }
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.value >= 30 {
                picker.selectRow(self.value - 30, inComponent: 0, animated: false)
            }
        }
    }
    
    private var value: Int = 0
    private var item: BPItem = .sys
    private var didSelected: ((Int)->Void)? = nil
}

extension SelectView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        270
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 76
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 42
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let view = view as? UILabel {
            view.text = "\(row + 30)"
            return view
        }
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: 76, height: 42)
        label.font = .systemFont(ofSize: 26)
        label.text = "\(row + 30)"
        label.textColor = UIColor(hex: 0x203E27)
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelected?(row + 30)
    }
}
