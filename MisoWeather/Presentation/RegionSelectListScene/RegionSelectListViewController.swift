//
//  RegionSelectListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/10.
//

import UIKit
import SnapKit

class RegionListViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = "어떤 지역의 날씨를 위한"
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .black)
        label.textColor = .black
        label.text = "간식거리🍩         "
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26.0, weight: .light)
        label.textColor = .black
        label.text = " 를 볼까요?"
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        return tableView
    }()
    
    @objc func nextVC() {
        self.navigationController?.pushViewController(NicknameSelectViewController(), animated: true)
    }
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        setupView()
    }
}

extension RegionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "중구"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension RegionListViewController: UITableViewDataSource {
    
}

extension RegionListViewController {
    
    // MARK: - Layout
    private func setupView() {
        [
            titleLabel,
            questionLabel,
            subTitleLabel,
            tableView,
            confirmButton
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(174.0)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).inset(5.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questionLabel.snp.bottom).offset(100.0)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo(300.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.frame.height * 0.096)
            $0.width.equalTo(view.frame.width - 96.0)
            $0.height.equalTo((view.frame.width - 96.0) * 0.15)
        }
    }
}
