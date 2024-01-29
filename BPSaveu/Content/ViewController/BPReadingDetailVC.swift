//
//  BPReadingDetailVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPReadingDetailVC: BaseVC {
    
    init(_ item: BPReadingItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var item: BPReadingItem = .protect {
        didSet {
            setupUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));
        navigationItem.title = "Details"
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

}

extension BPReadingDetailVC {
    
    override func setupUI() {
        super.setupUI()
        view.subviews.forEach({$0.removeFromSuperview()})
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hex: 0x272C2E)
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.text = item.title
        titleLabel.numberOfLines = 0
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(view.snp.width).offset(-40)
        }
        
        let bodyLable = UILabel()
        bodyLable.textColor = UIColor(hex: 0x30313C)
        bodyLable.font = .systemFont(ofSize: 14)
        bodyLable.text = item.description
        bodyLable.numberOfLines = 0
        scrollView.addSubview(bodyLable)
        bodyLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(BPReadingItemCell.classForCoder(), forCellReuseIdentifier: "BPReadingItemCell")
        tableView.separatorStyle = .none
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bodyLable.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(132 * 3)
        }
        
    }
}

extension BPReadingDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BPReadingItem.allCases.filter({$0 != item}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPReadingItemCell", for: indexPath)
        if let cell = cell as? BPReadingItemCell {
            cell.item = BPReadingItem.allCases.filter({$0 != item})[indexPath.row]
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        item = BPReadingItem.allCases.filter({$0 != item})[indexPath.row]
        tableView.reloadData()
    }
}
