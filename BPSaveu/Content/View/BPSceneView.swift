//
//  BPSceneView.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/26.
//

import UIKit

class BPSceneView: UIView {

    init(_ item: BPScene, selected: ((BPScene) -> Void)? = nil) {
        super.init(frame: .zero)
        self.item = item
        self.selected = selected
        setupUI()
    }
    
    private var item: BPScene = .night
    
    private var selected: ((BPScene)->Void)? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let contentView = UIView()
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        let contentBGView = UIView()
        contentView.backgroundColor = .white
        contentBGView.layer.cornerRadius = 24
        contentBGView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addSubview(contentBGView)
        contentBGView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Scene"
        titleLabel.textColor = UIColor(hex: 0x1D1D3A)
        titleLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewAlignFlowLayout())
        collectionView.register(BPSceneCollectionCell.classForCoder(), forCellWithReuseIdentifier: "BPScene")
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(90)
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
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
        
    }
    
    @objc func okAction() {
        self.removeFromSuperview()
        selected?(item)
    }
    
    @objc func onTap() {
        self.removeFromSuperview()
    }
}

extension BPSceneView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BPScene.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BPScene", for: indexPath)
        if let cell = cell as? BPSceneCollectionCell {
            cell.item = self.item
            cell.scene = BPScene.allCases[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = BPScene.allCases[indexPath.row]
        let width = item.title.textAutoWidth(height: 24.0, font: .systemFont(ofSize: 16))
        return CGSize(width: width + 32, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        item = BPScene.allCases[indexPath.row]
        collectionView.reloadData()
    }
}
