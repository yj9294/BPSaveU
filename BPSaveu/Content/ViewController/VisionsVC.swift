//
//  VisionsVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class VisionsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "visions_title"))
    }
}

extension VisionsVC {
    
    override func setupUI() {
        super.setupUI()
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BPReadingItemCell.classForCoder(), forCellReuseIdentifier: "BPReadingCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPReadingCell", for: indexPath)
        if let cell = cell as? BPReadingItemCell {
            cell.item = BPReadingItem.allCases[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BPReadingDetailVC(BPReadingItem.allCases[indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}


