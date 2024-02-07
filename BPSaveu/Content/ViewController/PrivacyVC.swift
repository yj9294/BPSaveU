//
//  PrivacyVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class PrivacyVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));
        navigationItem.title = "Privacy Policy"
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

}

extension PrivacyVC {
    
    override func setupUI() {
        super.setupUI()
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = UIColor(hex: 0x30313C)
        label.numberOfLines = 0
        label.text = """
Welcome to BP SAVEU. We take your privacy very seriously and are committed to protecting your personal information. Please read the following privacy Policy carefully before using our app to understand how we collect, use, store and protect personal information.
1. Information collected
In order to provide quality services, we may collect the following types of information:
- ** Information provided by users: ** When you register for an account, use app features, or contact us, you may be required to provide personal information, such as name, contact information, gender, etc.
- ** Information collected automatically: ** We may use Cookies and similar technologies to collect information about your use of the App, including device information, IP address, operating system and App usage.
- ** Blood pressure data: The main function of the application is to collect and analyze blood pressure data. This data will be stored in your personal account for the purpose of providing monitoring and analysis services.
2. Use of information
The information we collect will be used for the following purposes:
- Provide, maintain and improve the functions and services of the application.
- Analyze the health status of users and provide personalized health advice to users.
- Send app alerts and notifications to users.
- Handle user requests and feedback.
- Comply with legal and regulatory requirements.
3. Sharing of information
We promise not to sell, exchange or transfer your personal information to third parties. We will not share your information unless we have your express consent or to the extent permitted by law.
4. Safety measures
We take reasonable security measures to protect your personal information. This includes using encryption to protect the transmission of sensitive information, restricting who has access to your personal information, and conducting regular security reviews.
5. Children's privacy
Our app is not aimed at children under the age of 13. We do not knowingly collect personal information from children under the age of 13. If you are a parent or guardian and you find that your child has provided us with personal information, please contact us and we will delete the information immediately.
6. Privacy Policy Updates
We reserve the right to amend or update this Privacy policy at any time. Any material changes will be made through in-app notifications or by Posting an updated Privacy Policy on our website to keep users informed of changes.
By using BP SAVEU, you agree to the terms of this Privacy Policy. If you do not agree to these terms, please stop using our app.
If you have any questions or concerns regarding this Privacy Policy, please contact us . Thank you for choosing BP SAVEU, we will be happy to provide you with better service.
"""
        scrollView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(view.snp.width).offset(-32)
        }
        
    }
}
