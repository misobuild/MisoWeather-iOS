//
//  SettingViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/04.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let settingList = ["🔑  로그아웃", "📱  앱 버전", "💔  계정 삭제"]
    
    // MARK: - SubView
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 5
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .backgroundColor
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🐣"
        label.font = .systemFont(ofSize: 120)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "귀여운 막내병아리"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = settingList[indexPath.row]
        return cell
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까 🔒",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
    
        let cancle = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let confirm = UIAlertAction(title: "삭제", style: .default, handler: nil)
        
        alert.addAction(cancle)
        alert.addAction(confirm)
        present(alert, animated: true,completion: nil)
    }
}

extension SettingViewController {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
       
        [
            emojiLabel,
            titleLabel
        ].forEach {stackView.addArrangedSubview($0)}
        
        [
            stackView,
            tableView
        ].forEach {view.addSubview($0)}
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(28)
            $0.height.equalTo(215)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(30)
            $0.trailing.equalTo(stackView.snp.trailing)
            $0.leading.equalTo(stackView.snp.leading)
            $0.height.equalTo(60 * settingList.count)
        }
    }
}
