//
//  RegionSelectListView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/17.
//

import UIKit
import SnapKit

class RegionSelectListView: UIView {
    
    var regionList: [RegionList] = []
    var selectRegion = "선택 안 함"
    
    // MARK: - Subviews
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.questionLabel.text = "간식거리🍩"
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegionSelectListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        if regionList[1].smallScale == "선택 안 함"{
            cell.textLabel?.text = regionList[indexPath.row].midScale
        } else {
            cell.textLabel?.text = regionList[indexPath.row].smallScale
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRegion = regionList[indexPath.row].midScale
    }
}

extension RegionSelectListView: UITableViewDataSource {
    
}

extension RegionSelectListView {
    
    // MARK: - Layout
    private func setupView() {
        [
            titleLabel,
            tableView,
            confirmButton
        ].forEach {addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(174.0)
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(359.0)
            $0.width.equalTo(300.0)
            $0.height.equalTo(300.0)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100.0)
            $0.width.equalTo(300.0)
            $0.height.equalTo(50.0)
        }
    }
}
