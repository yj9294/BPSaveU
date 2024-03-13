//
//  VisionsVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit
import GoogleMobileAds

class VisionsVC: BaseVC {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BPReadingItemCell.classForCoder(), forCellReuseIdentifier: "BPReadingCell")
        tableView.register(BPReadingADCell.classForCoder(), forCellReuseIdentifier: "BPReadingADCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var ad: GADNativeAd? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    var viewAppear: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        addGADNatvieObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewAppear = true
            GADUtil.share.load(.native)
        }
        navigationItem.titleView = UIImageView(image: UIImage(named: "visions_title"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewAppear = false
        GADUtil.share.disappear(.native)
    }
    
    func addGADNatvieObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadNativeAD), name: .nativeUpdate, object: nil)
    }
    
    @objc func loadNativeAD(noti: Notification) {
        if let nativeModel = noti.object as? GADNativeModel {
            if viewAppear {
                ad = nativeModel.nativeAd
            } else {
                ad = nil
            }
        }
    }
}

extension VisionsVC {
    
    override func setupUI() {
        super.setupUI()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}

extension VisionsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BPReadingItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item =  BPReadingItem.allCases[indexPath.row]
        if item == .ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BPReadingADCell", for: indexPath)
            if let cell = cell as? BPReadingADCell {
                cell.ad = ad
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPReadingCell", for: indexPath)
        if let cell = cell as? BPReadingItemCell {
            cell.item = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GADUtil.share.load(.enter)
        GADUtil.share.show(.enter) { _ in
            let vc = BPReadingDetailVC(BPReadingItem.allCases[indexPath.row])
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


