//
//  SettingsVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class SettingsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "setting_title"))
    }

}

extension SettingsVC {
    override func setupUI() {
        super.setupUI()
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.classForCoder(), forCellReuseIdentifier: "SettingsCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(40)
            make.left.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-37)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        if let cell = cell as? SettingsCell {
            cell.item = SettingItem.allCases[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingItem.allCases[indexPath.row] {
        case .feedback:
            let vc = BPFeedbackVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .privacy:
            let vc = PrivacyVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
