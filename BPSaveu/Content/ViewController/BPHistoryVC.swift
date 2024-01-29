//
//  BPHistoryVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPHistoryVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var tableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(BPHistoryCell.classForCoder(), forCellReuseIdentifier: "BPHistoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));
        navigationItem.title = "Historical data"
        tableView.reloadData()
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

}

extension BPHistoryVC {
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension BPHistoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CacheUtil.shared.getBPModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPHistoryCell", for: indexPath)
        if let cell = cell as? BPHistoryCell {
            cell.model = CacheUtil.shared.getBPModels()[indexPath.row]
            cell.editHandle = { [weak self] model in
                let vc = BPVC(model, mode: .edit)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = CacheUtil.shared.getBPModels()[indexPath.row]
        let vc = BPVC(model, mode: .edit)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
