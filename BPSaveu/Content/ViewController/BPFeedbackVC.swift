//
//  BPFeedbackVC.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class BPFeedbackVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var placeholderLabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Enter your feedback"
        placeholderLabel.textColor = UIColor(hex: 0x878892)
        placeholderLabel.font = .systemFont(ofSize: 16)
        return placeholderLabel
    }()
    
    private lazy var submitButton = {
        let submitButton = UIButton()
        submitButton.setBackgroundImage(UIImage(named: "feedback_button"), for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = .systemFont(ofSize: 13)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.isEnabled = false
        return submitButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back));

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.title = "Recording Finished"

    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc func submit() {
        TipView.Show("We've processed your request.") {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension BPFeedbackVC {
    
    override func setupUI() {
        super.setupUI()
        
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.contentInset = UIEdgeInsets(top: 10, left: 14, bottom: 16, right: 16)
        textView.textColor = UIColor(hex: 0x30313C)
        textView.font = .systemFont(ofSize: 15)
        textView.delegate = self
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(220)
        }
        
        view.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(textView).offset(16)
            make.left.equalTo(textView).offset(16)
        }
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor  = UIColor(hex: 0x171A21).withAlphaComponent(0.5)
        label.text = "Within 100 characters"
        label.textAlignment = .right
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}


extension BPFeedbackVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text = String(textView.text.prefix(100))
        placeholderLabel.isHidden = textView.text.count > 0
        submitButton.isEnabled = textView.text.count > 0
    }
}
