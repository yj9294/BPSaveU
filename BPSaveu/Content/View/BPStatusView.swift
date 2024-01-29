//
//  BPStatusView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class BPStatusView: UIView {

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(okAction)))
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
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.register(BPStatusCell.classForCoder(), forCellWithReuseIdentifier: "BPStatus")
        let width = (UIScreen.main.bounds.width - 24 - 4.0 ) / 2.0 - 1
        let height = width * 88.0 / 166.0
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(height * 3 + 8)
        }
        
        let button = UIButton()
        button.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "guide_button"), for: .normal)
        button.setTitle("Got it", for: .normal)
        button.setTitleColor(.white, for: .normal)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
    }

    @objc func okAction() {
        self.removeFromSuperview()
    }
}

extension BPStatusView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BPStatus.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BPStatus", for: indexPath)
        if let cell = cell as? BPStatusCell {
            cell.item = BPStatus.allCases[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 24 - 4.0 ) / 2.0 - 1
        let height = width * 88.0 / 166.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    
}
