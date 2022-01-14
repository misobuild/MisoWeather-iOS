//
//  RegionSelectListViewController.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/10.
//

import UIKit
import SnapKit

class RegionListViewController: UIViewController {
    
    private let regionData: [String] = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "마포구", "노원구", "도봉구", "동대문구", "동작구", "금천구"]
    
    weak var delegate: SendDelegate?
    
    // MARK: - Subviews
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.questionLabel.text = "간식거리🍩"
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
                
        guard let data = self.delegate?.sendData() else {return}
        print("넘어온 데이터: \(data)")
        setupView()
    }
}

extension RegionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = regionData[indexPath.row]
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
            tableView,
            confirmButton
        ].forEach {view.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(174.0)
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(359.0)
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
